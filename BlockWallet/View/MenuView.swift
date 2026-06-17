import SwiftUI

struct MenuView: View {
    @Environment(SessionManager.self) private var session

    var onClose: () -> Void
    var switchTab: (TabBarItem) -> Void

    var body: some View {
        ZStack {
            AppGradient.primary.ignoresSafeArea().ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Text("Menu")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                WalletHeaderView()

                VStack(alignment: .leading, spacing: 4) {
                    Button { switchTab(.home) } label: {
                        MenuItem(icon: "house", title: "Home")
                    }
                    Button { switchTab(.market) } label: {
                        MenuItem(icon: "chart.bar", title: "Market")
                    }
                    NavigationLink(destination: SwapView()) {
                        MenuItem(icon: "arrow.up.arrow.down", title: "Swap")
                    }
                    
                    NavigationLink(destination: AssetsView()) {
                        MenuItem(icon: "wallet.bifold", title: "Assets")
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
            }
            .padding()
        }
    }
}

#Preview {
    MenuView(onClose: {}, switchTab: { _ in })
        .environment(SessionManager())
}
