import SwiftUI

struct MarketView: View {
    
    var coins: [CryptoCoin]
    
    @State private var titleMovers: String = "Destaques"
    @State private var titleNewMovers: String = "Novos"
    @State private var titleMoversAssets: String = "Maiores Movimentações"

    @State private var textButtonMovers: String = "Ver Todos"
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Header
            Text("Market")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.top)
            
            ScrollView {
                
                VStack(spacing: 24) {
                    
                    TopMoversView(title: $titleMovers, textButton: $textButtonMovers)
                    
                    TopMoversView(title: $titleNewMovers, textButton: $textButtonMovers)

                    TopMoversView(title: $titleMoversAssets, textButton: $textButtonMovers)

                }
                .padding(.horizontal)
            }
            
            BottomBarView(currentView: .market)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    MarketView(coins: mockCoins)
}
