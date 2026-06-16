import SwiftUI

struct AssetsView: View {
    
    @State private var search: String = ""
    
    var coins: [CryptoCoin]
    
    var body: some View {
        VStack(spacing: 16) {
            
            // MARK: SEARCH usando estilo do AmountField
            AmountField(
                value: $search,
                coin: "",
                icon: "magnifyingglass"
            ) {
                // não faz nada ao clicar
            }
            
            // MARK: LIST
            ScrollView {
                VStack(spacing: 16) {
                    
                    ForEach(coins) { coin in
                        AssetRow(coin: coin)
                    }
                }
            }
            
            Spacer()
            
            BottomBarView(currentView: .assets)
        }
        .padding()
        .background(AppGradient.primary.ignoresSafeArea().ignoresSafeArea())
    }
}

#Preview {
    AssetsView(coins: mockCoins)
}
