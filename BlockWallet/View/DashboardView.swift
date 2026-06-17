import SwiftUI
import SwiftData

struct DashboardView: View {
    @StateObject private var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    
    @State private var titleMovers: String = "Maiores Movimentações"
    @State private var textButtonMovers: String = "Ver Todos"
   
    
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HeaderView()
                
                BalanceView()
                
                ActionsView()
                
                BuyCryptoCard()
                
                TopMoversView(
                    cryptoCard: dashboardViewModel.cryptoCard,
                    title: $titleMovers,
                    textButton: $textButtonMovers)
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                async let coins: () = dashboardViewModel.loadCryptoCards(limit: 20)
                async let balance: () = WalletBalanceStore.shared.refresh()
                _ = await (coins, balance)
            }
        }
    }
}


#Preview {
    DashboardView()
}
