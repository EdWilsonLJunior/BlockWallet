import Foundation

/// CoinGecko cache/reference policy for BlockWallet Free Tier strategy.
///
/// Endpoints and TTLs:
/// - /coins/markets: memory 45s, SwiftData 5min
/// - /coins/{id}: memory 60s, SwiftData 10min
/// - /coins/price/simple: memory 30s, SwiftData 2min
/// - /coins/{id}/market_chart: memory 5min, no offline storage
/// - /coins/search/query: no cache, 500ms debounce
///
/// Networking constraints:
/// - Global limiter: 100 requests/minute
/// - Operation queue: max 3 concurrent network operations
/// - Timeout: 10s for request/resource
/// - Retry with exponential backoff: 1s -> 2s -> 4s -> 8s (max 3 retries)
/// - 429 handling: propagate `HTTPClientError.rateLimited` so UI can show
///   "Rate limit. Aguarde..." and optionally fallback to cache.
///
/// Additional strategy:
/// - Use batch `/coins/price/simple?ids=a,b,c` to avoid N-loop requests.
/// - CacheManager falls back to stale SwiftData snapshot in offline/error cases.
enum NetworkDocs {
    static let info = "CoinGecko Free Tier cache and rate-limit strategy"
}
