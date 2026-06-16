import SwiftUI

struct LoginView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var enableBiometric: Bool = true
    @State private var goToDashboard: Bool = false
    @State private var goToRegister: Bool = false
    @State private var isEmailInvalid: Bool = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil

    @Environment(SessionManager.self) private var session
    private let userService = UserService()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack (spacing: 20)
                {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250, maxHeight: 200)
                }
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(alignment: .leading) {
                        Text("Bem vindo")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Informe seus dados para continuar")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    EmailField(email: $email, isInvalid: $isEmailInvalid)
                    
                    PasswordField(
                        title: "Senha",
                        placeholder: "Insira sua senha",
                        text: $password
                    )
                    
                    BiometricToggleCard(isEnabled: $enableBiometric)
                    
                    Spacer()
                    
                    PrimaryButton(title: isLoading ? "Entrando..." : "Entrar") {
                        Task {
                            isLoading = true
                            errorMessage = nil
                            do {
                                _ = try await userService.login(email: email, password: password)
                                session.didLogin()
                            } catch {
                                errorMessage = "Email ou senha inválidos."
                            }
                            isLoading = false
                        }
                    }
                    .disabled(isLoading)

                    if let errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Button {
                        goToRegister = true
                    } label: {
                        Text("Registrar-se")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .navigationDestination(isPresented: $goToDashboard) {
                    DashboardView()
                        .navigationTitle("Dashboard")
                }
                .navigationDestination(isPresented: $goToRegister) {
                    RegisterView()
                }
            }
            .padding()
            .background(AppGradient.primary.ignoresSafeArea())
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
        .environment(SessionManager())
}
