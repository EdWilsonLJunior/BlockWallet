import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var enableBiometric: Bool = true
    @State private var goToDashboard: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {

                // Header
                HStack {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                
                Spacer().frame(height: 10)
                
                Text("Bem vindo")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text("Informe seus dados para continuar")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer().frame(height: 10)
                
                EmailField(email: $email)
                
                PasswordField(
                    title: "Senha",
                    placeholder: "Insira sua senha",
                    text: $password
                )
                
                BiometricToggleCard(isEnabled: $enableBiometric)
                
                Spacer()
                
                PrimaryButton(title: "Login") {
                    goToDashboard = true
                }

            }
            .padding()
            .background(Color.black.ignoresSafeArea())
            .navigationDestination(isPresented: $goToDashboard) {
                DashboardView()
                    .navigationTitle("Dashboard")
            }
        }
    }
}

#Preview {
    LoginView()
}
