import SwiftUI
import SwiftData

@main
struct BlockWalletApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                .modelContainer(for: User.self)
        }
    }
}
