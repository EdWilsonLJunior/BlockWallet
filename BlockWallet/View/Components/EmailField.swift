import SwiftUI

struct EmailField: View {
    
    @Binding var email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
                .foregroundColor(.white)
                .font(.subheadline)
            
            TextField("Enter your email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .foregroundColor(.white)
                .padding()
                .background(Color(white: 0.85))
                .cornerRadius(12)
        }
    }
}
