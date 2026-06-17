import SwiftUI

struct BuyCryptoCard: View {
    
    @AppStorage("buyCryptoCardDismissed") private var dismissed: Bool = false
    
    var body: some View {
        if !dismissed {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Text("Realize sua primeira compra!")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        dismissed = true
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }
                
                Text("Compre agora suas crypto com facilidade")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                Button(action: {}) {
                    Text("Comprar agora")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
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
}

#Preview {
    BuyCryptoCard()
}
