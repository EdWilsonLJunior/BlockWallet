import Foundation
import Security

enum KeychainKey: String {
    case accessToken  = "com.blockwallet.accessToken"
    case refreshToken = "com.blockwallet.refreshToken"
    case expiresAt    = "com.blockwallet.expiresAt"
}

struct KeychainService {

    @discardableResult
    static func save(_ value: String, for key: KeychainKey) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue,
            kSecValueData as String   : data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    static func read(for key: KeychainKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else { return nil }

        return string
    }

    @discardableResult
    static func delete(for key: KeychainKey) -> Bool {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue
        ]
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }

    static func clearTokens() {
        delete(for: .accessToken)
        delete(for: .refreshToken)
        delete(for: .expiresAt)
    }

    static func saveTokens(accessToken: String, refreshToken: String, expiresAt: TimeInterval) {
        save(accessToken, for: .accessToken)
        save(refreshToken, for: .refreshToken)
        save(String(expiresAt), for: .expiresAt)
    }

    static var isTokenValid: Bool {
        guard let raw = read(for: .expiresAt),
              let expiresAt = TimeInterval(raw) else { return false }
        return Date().timeIntervalSince1970 < expiresAt
    }

    static var accessToken: String? { read(for: .accessToken) }
    static var refreshToken: String? { read(for: .refreshToken) }
}
