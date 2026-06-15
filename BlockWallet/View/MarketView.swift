import SwiftUI

struct MarketView: View {
    
    @StateObject private var viewModel: DashboardViewModel = DashboardViewModel()
        
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
                    
                    TopMoversView(
                        cryptoCard: viewModel.cryptoCard,
                        title: $titleMovers,
                        textButton: $textButtonMovers)
                }
                .padding(.horizontal)
            }
            
            BottomBarView(currentView: .market)
        }
        .background(Color.black.ignoresSafeArea())
        .task {
            await viewModel.loadCryptoCards(limit: 10)
        }
    }
}

#Preview {
    MarketView(coins: mockCoins)
}
