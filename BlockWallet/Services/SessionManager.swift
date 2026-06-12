import SwiftUI

@Observable
class SessionManager {
    var isAuthenticated: Bool = KeychainService.isTokenValid

    func logout() {
        KeychainService.clearTokens()
        isAuthenticated = false
    }

    func didLogin() {
        isAuthenticated = true
    }
}
