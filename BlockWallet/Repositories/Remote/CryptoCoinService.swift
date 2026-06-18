//
//  CoinService.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 14/06/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case decodingError
    case unauthorized
}

class CryptoCoinService {
    
    init () {}
    static let shared = CryptoCoinService()

    private let coinGeckoService = CoinGeckoService.shared
    
    func getCoins(limit: Int) async throws -> [CryptoCoinResponse] {
        try await coinGeckoService.fetchMarkets(perPage: limit, vsCurrency: "brl")
    }

    func getCoinDetail(id: String) async throws -> CryptoCoinDetailResponse {
        try await coinGeckoService.fetchCryptoCoinDetail(id: id)
    }

    func getWalletHoldings(accessToken: String) async throws -> [WalletHoldingResponse] {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/wallet") else {
            throw NetworkError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        if http.statusCode == 401 { throw NetworkError.unauthorized }
        guard (200...299).contains(http.statusCode) else { throw NetworkError.invalidData }

        print("[Wallet] raw: \(String(data: data, encoding: .utf8) ?? "")")
        let decoded = try JSONDecoder().decode(ResponseData<[WalletHoldingResponse]>.self, from: data)
        return decoded.data
    }

    func fetchChart(id: String) async throws -> [ChartDataPoint] {
        let chartResponse = try await coinGeckoService.fetchMarketChart(id: id)
        return chartResponse.prices.compactMap { pair -> ChartDataPoint? in
            guard pair.count >= 2 else { return nil }
            return ChartDataPoint(
                timestamp: Date(timeIntervalSince1970: pair[0] / 1000),
                price: pair[1]
            )
        }
    }

    func getDashboardBalance(accessToken: String) async throws -> Double {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/profile/dashboard") else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        if httpResponse.statusCode == 401 { throw NetworkError.unauthorized }
        guard (200...299).contains(httpResponse.statusCode) else { throw NetworkError.invalidData }

        let decoded = try JSONDecoder().decode(ResponseData<DashboardData>.self, from: data)
        return decoded.data.simulatedBalanceUsd
    }

    func getSimplePrice(coinId: String) async throws -> Double {
        let prices = try await coinGeckoService.fetchPrice(ids: [coinId], vsCurrencies: ["usd"])
        guard let coinPrice = prices[coinId],
              let price = coinPrice["usd"] else {
            throw NetworkError.invalidData
        }
        return price
    }

    func buyCrypto(request buyRequest: BuyCryptoRequest, accessToken: String) async throws {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/wallet/buy") else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(buyRequest)

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        if httpResponse.statusCode == 401 {
            throw NetworkError.unauthorized
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidData
        }
    }

    func sellCrypto(request sellRequest: BuyCryptoRequest, accessToken: String) async throws {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/wallet/sell") else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONEncoder().encode(sellRequest)

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        if httpResponse.statusCode == 401 {
            throw NetworkError.unauthorized
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidData
        }
    }

    func getWalletBalance(accessToken: String) async throws -> Double {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/wallet") else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        if httpResponse.statusCode == 401 {
            throw NetworkError.unauthorized
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidData
        }

        let json = try JSONSerialization.jsonObject(with: data)
        guard let root = json as? [String: Any], let payload = root["data"] else {
            throw NetworkError.invalidData
        }

        guard let balance = extractWalletBalance(from: payload) else {
            throw NetworkError.invalidData
        }

        return balance
    }

    private func extractWalletBalance(from payload: Any) -> Double? {
        let candidateKeys = [
            "totalBalance",
            "balance",
            "walletBalance",
            "availableBalance",
            "fiatBalance",
            "cashBalance",
            "brlBalance",
            "usdBalance",
            "total_balance",
            "total_brl",
            "total_usd"
        ]

        if let dictionary = payload as? [String: Any] {
            for key in candidateKeys {
                if let value = dictionary[key], let number = numericValue(from: value) {
                    return number
                }
            }

            for value in dictionary.values {
                if let number = extractWalletBalance(from: value) {
                    return number
                }
            }
        }

        if let array = payload as? [Any] {
            for item in array {
                if let number = extractWalletBalance(from: item) {
                    return number
                }
            }
        }

        return nil
    }

    private func numericValue(from value: Any) -> Double? {
        if let number = value as? NSNumber {
            return number.doubleValue
        }

        if let number = value as? Double {
            return number
        }

        if let number = value as? Int {
            return Double(number)
        }

        if let text = value as? String {
            return Double(text.replacingOccurrences(of: ",", with: "."))
        }

        return nil
    }
}
