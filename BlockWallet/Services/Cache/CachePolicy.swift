import Foundation

enum CacheEndpoint {
    case markets(perPage: Int, vsCurrency: String)
    case coinDetail(id: String)
    case simplePrice(ids: [String], currencies: [String])
    case marketChart(id: String, days: String)
    case search(query: String)

    var key: String {
        switch self {
        case .markets(let perPage, let vsCurrency):
            return "coins_markets_\(perPage)_\(vsCurrency)"
        case .coinDetail(let id):
            return "coin_detail_\(id)"
        case .simplePrice(let ids, let currencies):
            let normalizedIds = ids.map { $0.lowercased() }.sorted().joined(separator: ",")
            let normalizedCurrencies = currencies.map { $0.lowercased() }.sorted().joined(separator: ",")
            return "simple_price_\(normalizedIds)_\(normalizedCurrencies)"
        case .marketChart(let id, let days):
            return "market_chart_\(id)_\(days)"
        case .search(let query):
            return "search_\(query.lowercased())"
        }
    }

    var path: String {
        switch self {
        case .markets:
            return "/api/v1/coins/markets"
        case .coinDetail(let id):
            return "/api/v1/coins/\(id)"
        case .simplePrice:
            return "/api/v1/coins/price/simple"
        case .marketChart(let id, _):
            return "/api/v1/coins/\(id)/chart"
        case .search:
            return "/api/v1/coins/search/query"
        }
    }

    var memoryTTL: TimeInterval? {
        switch self {
        case .markets:
            return 45
        case .coinDetail:
            return 60
        case .simplePrice:
            return 30
        case .marketChart:
            return 300
        case .search:
            return nil
        }
    }

    var swiftDataTTL: TimeInterval? {
        switch self {
        case .markets:
            return 300
        case .coinDetail:
            return 600
        case .simplePrice:
            return 120
        case .marketChart:
            return nil
        case .search:
            return nil
        }
    }

    var debounceMilliseconds: UInt64? {
        switch self {
        case .search:
            return 500
        default:
            return nil
        }
    }
}
