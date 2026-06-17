import Foundation
import SwiftData

@Model
final class APICacheEntry {
    @Attribute(.unique) var key: String
    var endpoint: String
    var payload: Data
    var createdAt: Date
    var expiresAt: Date

    init(key: String, endpoint: String, payload: Data, createdAt: Date = .now, expiresAt: Date) {
        self.key = key
        self.endpoint = endpoint
        self.payload = payload
        self.createdAt = createdAt
        self.expiresAt = expiresAt
    }
}
