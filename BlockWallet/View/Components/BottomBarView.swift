import SwiftUI

struct BottomBarView: View {

    @Binding var currentTab: TabBarItem
    var switchTab: (TabBarItem) -> Void

    var body: some View {
        ZStack {

            HStack {
                NavItem(icon: "house", title: "Home", item: .home, currentPage: currentTab) {
                    switchTab(.home)
                }

                Spacer()
                    .frame(width: 40)

                NavItem(icon: "chart.bar", title: "Loja", item: .market, currentPage: currentTab) {
                    switchTab(.market)
                }

                Spacer()
                    .frame(width: 80)

                NavItem(icon: "wallet.pass", title: "Carteira", item: .assets, currentPage: currentTab) {
                    switchTab(.assets)
                }

                Spacer()
                    .frame(width: 40)

                NavItem(icon: "line.3.horizontal", title: "Menu", item: .menu, currentPage: currentTab) {
                    switchTab(.menu)
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
    NavigationStack {
        BottomBarView(currentTab: .constant(.home), switchTab: { _ in })
    }
}
