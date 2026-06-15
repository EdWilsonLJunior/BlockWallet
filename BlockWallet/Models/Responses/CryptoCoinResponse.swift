//
//  CoinResponse.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 14/06/26.
//

import Foundation

struct CryptoCoinResponse: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String?
    let currentPrice: Double
    let priceChangePercentage24h: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}
