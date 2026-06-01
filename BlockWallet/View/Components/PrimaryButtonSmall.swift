import SwiftUI

struct PrimaryButtonSmall: View {
    let title: String
    
    var body: some View {
        Button(action: {}) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(20)
        }
    }
}

#Preview {
    PrimaryButtonSmall(title: "Tittle")
}
