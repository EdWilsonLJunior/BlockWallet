import SwiftUI

struct PasswordField: View {
    let title: String
    let placeholder: String
    
    @Binding var text: String
    @State private var isSecure: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)
            
            HStack {
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.white)
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.fill" : "eye.slash.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color(white: 0.85))
            .cornerRadius(12)
        }
    }
}

