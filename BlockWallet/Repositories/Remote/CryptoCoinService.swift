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
}

class CryptoCoinService {
    
    init () {}
    static let shared = CryptoCoinService()
    
    func getCoins(limit: Int) async throws -> [CryptoCoinResponse] {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/coins/markets?page=1&per_page=\(limit)&vs_currencies=brl") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            
            let responseData = try JSONDecoder().decode(ResponseData<[CryptoCoinResponse]>.self, from: data)
            return responseData.data
            
        } catch {
            print(error.localizedDescription)
            throw NetworkError.decodingError
        }
    }
    
    func getCoinDetail(id: String) async throws -> CryptoCoinDetailResponse {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/coins/\(id)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, reponse) = try await URLSession.shared.data(from: url)
        
        do {
            guard let http = reponse as? HTTPURLResponse, http.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }
            
            let responseData = try JSONDecoder().decode(ResponseData<CryptoCoinDetailResponse>.self, from: data)
            
            return responseData.data
        } catch {
            print(error.localizedDescription)
            throw NetworkError.decodingError
        }
        
    }
    
    func fetchChart(id: String) async throws -> [ChartDataPoint] {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/coins/\(id)/chart") else {
            throw NetworkError.invalidURL
        }
        
        print(url.absoluteString)

        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let response  = try JSONDecoder().decode(CoinChartResponse.self, from: data)

            return response.data.prices.map { values in
                ChartDataPoint(
                    timestamp: Date(timeIntervalSince1970: values[0] / 1000),
                    price: values[1]
                )
            }
        } catch {
            print(error.localizedDescription)
            throw NetworkError.decodingError
        }
        
        
    }

}
