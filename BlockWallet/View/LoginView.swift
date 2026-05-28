import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var enableBiometric: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            // Header
            HStack(alignment: .center) {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            
            Spacer().frame(height: 10)
            
            // Title
            Text("Bem vindo")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            
            Text("Informe seus dados para continuar")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer().frame(height: 10)
            
            // Email Field
            EmailField(email: $email)
            
            // Password Field (reutilizado)
            PasswordField(
                title: "Senha",
                placeholder: "Insira sua senha",
                text: $password
            )
            
            // Biometric toggle
            BiometricToggleCard(isEnabled: $enableBiometric)
            
            Spacer()
            
            // Login Button
            PrimaryButton(title: "Login") {
                print("Login clicado")
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}


#Preview {
    LoginView()
}
