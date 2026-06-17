import Foundation

final class CoinGeckoService {
    static let shared = CoinGeckoService()

    private let httpClient: HTTPClient
    private let cacheManager: CacheManager

    init(
        httpClient: HTTPClient = .shared,
        cacheManager: CacheManager = .shared
    ) {
        self.httpClient = httpClient
        self.cacheManager = cacheManager
    }

    func fetchMarkets(
        page: Int = 1,
        perPage: Int = 50,
        order: String = "market_cap_desc",
        vsCurrency: String = "usd"
    ) async throws -> [CryptoCoinResponse] {
        let endpoint = CacheEndpoint.markets(perPage: perPage, vsCurrency: vsCurrency)
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage)),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "vs_currency", value: vsCurrency)
        ]

        let response: ResponseData<[CryptoCoinResponse]> = try await cacheManager.fetch(
            endpoint: endpoint,
            decode: ResponseData<[CryptoCoinResponse]>.self
        ) {
            try await self.httpClient.requestData(
                path: endpoint.path,
                method: .get,
                queryItems: queryItems
            )
        }

        return response.data
    }

    func fetchPrice(ids: [String], vsCurrencies: [String] = ["usd"]) async throws -> [String: [String: Double]] {
        let endpoint = CacheEndpoint.simplePrice(ids: ids, currencies: vsCurrencies)
        let queryItems = [
            URLQueryItem(name: "ids", value: ids.joined(separator: ",")),
            URLQueryItem(name: "vs_currencies", value: vsCurrencies.joined(separator: ","))
        ]

        let response: ResponseData<[String: [String: Double]]> = try await cacheManager.fetch(
            endpoint: endpoint,
            decode: ResponseData<[String: [String: Double]]>.self
        ) {
            try await self.httpClient.requestData(
                path: endpoint.path,
                method: .get,
                queryItems: queryItems
            )
        }

        return response.data
    }

    func fetchCoinDetail(id: String) async throws -> CoinDetailResponse {
        let endpoint = CacheEndpoint.coinDetail(id: id)

        let response: ResponseData<CoinDetailResponse> = try await cacheManager.fetch(
            endpoint: endpoint,
            decode: ResponseData<CoinDetailResponse>.self
        ) {
            try await self.httpClient.requestData(path: endpoint.path)
        }

        return response.data
    }

    func fetchMarketChart(id: String, days: String = "7", vsCurrency: String = "usd") async throws -> MarketChartResponse {
        let endpoint = CacheEndpoint.marketChart(id: id, days: days)
        let queryItems = [
            URLQueryItem(name: "days", value: days),
            URLQueryItem(name: "vs_currency", value: vsCurrency)
        ]

        let response: ResponseData<MarketChartResponse> = try await cacheManager.fetch(
            endpoint: endpoint,
            decode: ResponseData<MarketChartResponse>.self
        ) {
            try await self.httpClient.requestData(
                path: endpoint.path,
                method: .get,
                queryItems: queryItems
            )
        }

        return response.data
    }

    func fetchTrending() async throws -> TrendingResponse {
        let response: TrendingResponse = try await httpClient.request(
            path: "/api/v1/coins/trending",
            method: .get,
            decode: TrendingResponse.self
        )

        return response
    }

    func searchCoins(query: String) async throws -> SearchCoinsResponse {
        let endpoint = CacheEndpoint.search(query: query)
        let queryItems = [URLQueryItem(name: "q", value: query)]

        return try await cacheManager.fetch(
            endpoint: endpoint,
            decode: SearchCoinsResponse.self
        ) {
            try await self.httpClient.requestData(
                path: endpoint.path,
                method: .get,
                queryItems: queryItems
            )
        }
    }
}
