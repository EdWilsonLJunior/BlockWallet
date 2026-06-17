//
//  Coin.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 29/05/26.
//

import Foundation
import SwiftData

@Model
class CryptoCoin: Identifiable {
    var id: String
    var name: String
    var symbol: String
    var image: String
    var priceChangePercentage24h: Double
    
    init(id: String, name: String, symbol: String,  image: String, priceChangePercentage24h: Double) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image = image
        self.priceChangePercentage24h = priceChangePercentage24h
    }
}


extension CryptoCoin {
    static func from(cryptoCoinResponse: CryptoCoinResponse) -> CryptoCoin {
        return CryptoCoin(
            id: cryptoCoinResponse.id,
            name: cryptoCoinResponse.name,
            symbol: cryptoCoinResponse.symbol,
            image: cryptoCoinResponse.image ?? "",
            priceChangePercentage24h: cryptoCoinResponse.priceChangePercentage24h ?? 0.0
        )
    }
}
