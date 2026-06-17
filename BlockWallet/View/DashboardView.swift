import SwiftUI
import SwiftData

struct DashboardView: View {
    @StateObject private var dashboardViewModel = DashboardViewModel.shared
    
    @State private var titleMovers: String = "Maiores Movimentações"
    @State private var textButtonMovers: String = "Ver Todos"
   
    
    var body: some View {
        
        ZStack {
            AppGradient.primary.ignoresSafeArea().ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HeaderView()
                
                BalanceView()
                
                ActionsView()
                
                TopMoversView(
                    cryptoCard: dashboardViewModel.cryptoCard,
                    title: $titleMovers,
                    textButton: $textButtonMovers)
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    DashboardView()
}
