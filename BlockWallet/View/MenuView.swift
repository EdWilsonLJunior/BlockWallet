import SwiftUI

struct MenuView: View {
    @Environment(SessionManager.self) private var session
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Text("Menu")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                WalletHeaderView()
                
                VStack(spacing: 20) {
                    NavigationLink(destination: DashboardView()) {
                        MenuItem(icon: "house", title: "Home")
                    }
                    
                    NavigationLink(destination: MarketView(coins: mockCoins)) {
                        MenuItem(icon: "chart.bar", title: "Market")
                    }
                    
                    NavigationLink(destination: SwapView()) {
                        MenuItem(icon: "arrow.up.arrow.down", title: "Swap")
                    }
                    
                    NavigationLink(destination: AssetsView(coins: mockCoins)) {
                        MenuItem(icon: "wallet.pass", title: "Assets")
                    }
                }
                
                Divider()
                    .background(Color.gray.opacity(0.4))
                Button {
                    session.logout()
                } label: {
                    MenuItem(icon: "arrow.backward.circle", title: "Log Out", isDestructive: true)
                }
                                    
                Spacer()
                
                BottomBarView(currentView: .menu)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MenuView()
        .environment(SessionManager())
}
