//
//  CoinRepository.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 14/06/26.
//

import Foundation

protocol CryptoCoinRepositoryProtocol {
    func getCoins(limit: Int) async throws -> [CryptoCoinResponse]
    func getCoinDetail(id: String) async throws -> CryptoCoinDetailResponse
    func getChart(id: String) async throws -> [ChartDataPoint]
}

class CryptoCoinRepository: CryptoCoinRepositoryProtocol {
    
    //private let local: CryptoCoinLocalService
    
//    init(local: CryptoCoinLocalService) {
//        self.local = local
//    }
    
    func getCoins(limit: Int) async throws -> [CryptoCoinResponse] {
        do {
            let cryptoCoinsResponse = try await CryptoCoinService.shared.getCoins(limit: limit)
            
//            local.deleteall()
//            local.save(coins: cryptoCoinsResponse)
            
            return cryptoCoinsResponse
        } catch {
            print(error)
            return []
//            let cached = local.fetchCoins()
//            
//            if cached.isEmpty {
//               throw error
//            }
//            
//            return cached.map {
//                CryptoCoinResponse(
//                    id: $0.id,
//                    symbol: $0.symbol,
//                    name: $0.name,
//                    image: $0.image,
//                    priceChangePercentage24h: $0.priceChangePercentage24h
//                )
//            }
        }
    }
    
    func getCoinDetail(id: String) async throws -> CryptoCoinDetailResponse {
        //do {
            let cryptCoinDetailresponse = try await CryptoCoinService.shared.getCoinDetail(id: id)
            
            return cryptCoinDetailresponse
       /* } catch {
            return nil
        }*/
    }
    
    func getChart(id: String) async throws -> [ChartDataPoint] {
        let chartResponse = try await CryptoCoinService.shared.fetchChart(id: id)
        print(chartResponse)
        return chartResponse
    }
}
