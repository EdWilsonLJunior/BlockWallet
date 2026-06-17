import SwiftUI
import SwiftData

@main
struct BlockWalletApp: App {
    @State private var session = SessionManager()
    //private let container: ModelContainer
    
//    init() {
//        do {
//            container = try ModelContainer(
//                for: CryptoCoin.self
//            )
//        } catch {
//            fatalError("Error ao criar model container: \(error)")
//        }
//    }

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
