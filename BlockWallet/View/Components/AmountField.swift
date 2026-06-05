import SwiftUI

struct AmountField: View {
    
    @Binding var value: String
    var coin: String
    var icon: String
    var onSelectCoin: () -> Void
    
    var body: some View {
        HStack {
            
            TextField("Search Token", text: $value)
                .foregroundColor(.white)
            
            Spacer()
            
            if coin != "" {
                Button {
                    onSelectCoin()
                } label: {
                    HStack {
                        Image(systemName: icon)
                        Text(coin)
                    }
                }
            } else {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }
}
