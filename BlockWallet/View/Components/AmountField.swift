import SwiftUI

struct AmountField: View {
    
    @Binding var value: String
    var coin: String
    var icon: String
    var onSelectCoin: () -> Void
    
    var body: some View {
        HStack {
            
            TextField("0.0", text: $value)
                .foregroundColor(.white)
                .font(.title3)
            
            Spacer()
            
            Button {
                onSelectCoin() // ✅ abre modal
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: icon)
                        .foregroundColor(.orange)
                    
                    Text(coin)
                        .foregroundColor(.white)
                        .bold()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}
