import Foundation

final class CacheManager {
    static let shared = CacheManager()

    private let memoryCache: InMemoryCache
    private let swiftDataCache: SwiftDataCacheStore

    init(
        memoryCache: InMemoryCache = InMemoryCache(),
        swiftDataCache: SwiftDataCacheStore = .shared
    ) {
        self.memoryCache = memoryCache
        self.swiftDataCache = swiftDataCache
    }

    func fetch<T: Decodable>(
        endpoint: CacheEndpoint,
        decode type: T.Type,
        remote: () async throws -> Data
    ) async throws -> T {
        if let memoryData = memoryCache.load(for: endpoint.key) {
            return try JSONDecoder().decode(T.self, from: memoryData)
        }

        if let swiftData = try? await swiftDataCache.loadValid(endpoint: endpoint) {
            memoryCache.save(swiftData, for: endpoint.key, ttl: endpoint.memoryTTL)
            return try JSONDecoder().decode(T.self, from: swiftData)
        }

        do {
            if let debounce = endpoint.debounceMilliseconds {
                try? await Task.sleep(nanoseconds: debounce * 1_000_000)
            }

            let data = try await remote()
            memoryCache.save(data, for: endpoint.key, ttl: endpoint.memoryTTL)
            try? await swiftDataCache.save(data, endpoint: endpoint, ttl: endpoint.swiftDataTTL)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if let staleData = try? await swiftDataCache.loadAny(endpoint: endpoint) {
                return try JSONDecoder().decode(T.self, from: staleData)
            }
            throw error
        }
    }
}
