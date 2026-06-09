import SwiftUI

struct EmailField: View {
    
    @Binding var email: String
    @FocusState private var isEmailFocused: Bool
    @Binding var isInvalid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .foregroundColor(.white)
                .font(.subheadline)
            
            TextField("Inform seu e-mail", text: $email)
                .focused($isEmailFocused)
                .onChange(of: isEmailFocused) { _, focused in // Os parâmetros são oldValue and newValue
                    if !focused {
                        print("Perdeu o foco \(self.email)")
                        self.isInvalid = !self.isValidEmail(email: self.email)
                    }
                }

                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .foregroundColor(.black)
                .padding()
                .background(Color(white: 0.85))
                .cornerRadius(12)
            
            if isInvalid {
                Text("Email é inválido")
                    .font(.caption)
                    .foregroundColor(.red)
            }          
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
}
