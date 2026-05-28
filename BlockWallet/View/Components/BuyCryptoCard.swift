import SwiftUI

struct BuyCryptoCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Text("Realize sua primeira compra!")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }
            
            Text("Compre agora suas crypto com facilidade")
                .foregroundColor(.gray)
                .font(.caption)
            
            Button(action: {}) {
                Text("Comprar agora")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.black)
                    .cornerRadius(25)
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.gray.opacity(0.2), Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
    }
}

#Preview {
    BuyCryptoCard()
}
