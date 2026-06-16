import SwiftUI
import SwiftData

struct DashboardView: View {
    @StateObject private var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    
    @State private var titleMovers: String = "Maiores Movimentações"
    @State private var textButtonMovers: String = "Ver Todos"
   
    
    var body: some View {
        
        ZStack {
            AppGradient.primary.ignoresSafeArea().ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HeaderView()
                
                BalanceView()
                
                ActionsView()
                
                BuyCryptoCard()
                
                TopMoversView(
                    cryptoCard: dashboardViewModel.cryptoCard,
                    title: $titleMovers,
                    textButton: $textButtonMovers)
                
                Spacer()
                
                BottomBarView(currentView: .home)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await dashboardViewModel.loadCryptoCards(limit: 4)
        }
    }
}


#Preview {
    DashboardView()
}
