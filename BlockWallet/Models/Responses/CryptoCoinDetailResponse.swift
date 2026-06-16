//
//  CryptoCoinDetailResponse.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 15/06/26.
//

import Foundation

struct CryptoCoinDetailResponse: Codable {
    let id: String
    let symbol: String
    let name: String
    let image: CoinImage
    let marketData: MarketData
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case marketData = "market_data"
    }
}

struct CoinImage: Codable {
    let thumb: String
    let small: String
    let large: String
}

struct MarketData: Codable {
    let currentPrice: [String: Double]
    let marketCap: [String: Double]
    let ath: [String: Double]
    let atl: [String: Double]
    let priceChange24h: Double
    let priceChangePercentage24h: Double
    let circulatingSupply: Double
    let totalSupply: Double?
    let maxSupply: Double?

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case ath, atl
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
    }
}
