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
}
