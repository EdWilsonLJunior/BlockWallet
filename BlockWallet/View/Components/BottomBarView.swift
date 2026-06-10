import SwiftUI

struct BottomBarView: View {
    
    var currentView: TabBarItem = .home
    
    var body: some View {
        ZStack {
            
            HStack {
                NavItem(icon: "house", title: "Home", item: currentView, currentPage: .home ) {
                    DashboardView()
                }
                
                Spacer()
                    .frame(width: 40)
                
                NavItem(icon: "chart.bar", title: "Market", item: currentView, currentPage: .market) {
                    MarketView(coins: mockCoins)
                }
                
                Spacer()
                    .frame(width: 80)
                
                NavItem(icon: "wallet.pass", title: "Assets", item: currentView, currentPage: .assets) {
                    AssetsView(coins: mockCoins)
                }
                
                Spacer()
                    .frame(width: 40)
                
                NavItem(icon: "line.3.horizontal", title: "Menu", item: currentView, currentPage: .menu) {
                    MenuView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            NavigationLink(destination: SwapView()) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.white)
                    )
            }
            .offset(y: -25)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BottomBarView()
}
