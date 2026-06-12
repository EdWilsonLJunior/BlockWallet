import SwiftUI
import SwiftData

@main
struct BlockWalletApp: App {
    @State private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            if session.isAuthenticated {
                NavigationStack {
                    DashboardView()
                }
                .environment(session)
            } else {
                LoginView()
                    .environment(session)
            }
        }
    }
}
