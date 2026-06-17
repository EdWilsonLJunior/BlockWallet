import Foundation

final class InMemoryCache {
    private final class CacheEntry {
        let data: Data
        let expiresAt: Date

        init(data: Data, expiresAt: Date) {
            self.data = data
            self.expiresAt = expiresAt
        }
    }

    private let cache = NSCache<NSString, CacheEntry>()

    func save(_ data: Data, for key: String, ttl: TimeInterval?) {
        guard let ttl else { return }
        let entry = CacheEntry(data: data, expiresAt: Date().addingTimeInterval(ttl))
        cache.setObject(entry, forKey: key as NSString)
    }

    func load(for key: String) -> Data? {
        guard let entry = cache.object(forKey: key as NSString) else {
            return nil
        }

        if Date() > entry.expiresAt {
            cache.removeObject(forKey: key as NSString)
            return nil
        }

        return entry.data
    }

    func remove(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
