import SwiftUI

struct MenuView: View {
    @Environment(SessionManager.self) private var session

    var onClose: () -> Void
    var switchTab: (TabBarItem) -> Void

    var body: some View {
        ZStack {
            Color(white: 0.08).ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {

                HStack {
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                }

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
                    Button { switchTab(.assets) } label: {
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
            }
            .padding()
        }
    }
}

#Preview {
    MenuView(onClose: {}, switchTab: { _ in })
        .environment(SessionManager())
}
