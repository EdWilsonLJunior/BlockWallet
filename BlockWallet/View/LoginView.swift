import SwiftUI

struct LoginView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var enableBiometric: Bool = true
    @State private var goToDashboard: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .leading) {
                        Text("Bem vindo")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Informe seus dados para continuar")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    EmailField(email: $email)
                    
                    PasswordField(
                        title: "Senha",
                        placeholder: "Insira sua senha",
                        text: $password
                    )
                    
                    BiometricToggleCard(isEnabled: $enableBiometric)
                    
                    Spacer()
                    
                    PrimaryButton(title: "Entrar") {
                        goToDashboard = true
                    }

                }               
                .navigationDestination(isPresented: $goToDashboard) {
                    DashboardView()
                        .navigationTitle("Dashboard")
                }
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
        }
    }
}

#Preview {
    LoginView()
}
