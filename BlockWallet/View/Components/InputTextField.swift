import SwiftUI

struct InputTextField: View {
    
    @Binding var text: String
    @Binding var placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(text)
                .foregroundColor(.white)
                .font(.subheadline)
            
            TextField(placeholder, text: $value)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .foregroundColor(.black)
                .padding()
                .background(Color(white: 0.85))
                .cornerRadius(12)
        }
    }
}
