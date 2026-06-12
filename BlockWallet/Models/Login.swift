import Foundation
import SwiftData

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct AuthUser: Codable {
    let id: String
    let email: String
}

struct LoginData: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: TimeInterval
    let user: AuthUser
}
