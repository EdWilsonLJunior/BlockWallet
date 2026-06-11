import SwiftUI

struct DashboardView: View {
    
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
                
                TopMoversView(title: $titleMovers, textButton: $textButtonMovers)
                
                Spacer()
                
                BottomBarView(currentView: .home)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView()
}
