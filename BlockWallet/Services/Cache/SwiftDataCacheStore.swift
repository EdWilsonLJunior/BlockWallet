import Foundation
import SwiftData

actor SwiftDataCacheStore {
    static let shared = SwiftDataCacheStore()

    private let container: ModelContainer

    init(container: ModelContainer? = nil) {
        if let container {
            self.container = container
        } else {
            do {
                self.container = try ModelContainer(for: APICacheEntry.self)
            } catch {
                fatalError("Failed to create cache ModelContainer: \(error)")
            }
        }
    }

    func save(_ data: Data, endpoint: CacheEndpoint, ttl: TimeInterval?) throws {
        guard let ttl else { return }

        let context = ModelContext(container)
        let key = endpoint.key
        let descriptor = FetchDescriptor<APICacheEntry>(predicate: #Predicate { $0.key == key })

        if let existing = try context.fetch(descriptor).first {
            existing.payload = data
            existing.endpoint = endpoint.path
            existing.createdAt = .now
            existing.expiresAt = Date().addingTimeInterval(ttl)
        } else {
            let entry = APICacheEntry(
                key: key,
                endpoint: endpoint.path,
                payload: data,
                createdAt: .now,
                expiresAt: Date().addingTimeInterval(ttl)
            )
            context.insert(entry)
        }

        try context.save()
    }

    func loadValid(endpoint: CacheEndpoint) throws -> Data? {
        let context = ModelContext(container)
        let key = endpoint.key
        let descriptor = FetchDescriptor<APICacheEntry>(predicate: #Predicate { $0.key == key })

        guard let entry = try context.fetch(descriptor).first else {
            return nil
        }

        if Date() <= entry.expiresAt {
            return entry.payload
        }

        return nil
    }

    func loadAny(endpoint: CacheEndpoint) throws -> Data? {
        let context = ModelContext(container)
        let key = endpoint.key
        let descriptor = FetchDescriptor<APICacheEntry>(predicate: #Predicate { $0.key == key })
        return try context.fetch(descriptor).first?.payload
    }
}
