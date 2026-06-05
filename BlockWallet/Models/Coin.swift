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
    var currentPrive: String
    var priceChangePercentege24h: String
    var image: String
    var marketCapRank: String
 
    init(id: String, name: String, symbol: String, currentPrive: String, priceChangePercentege24h: String, image: String, marketCapRank: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.currentPrive = currentPrive
        self.priceChangePercentege24h = priceChangePercentege24h
        self.image = image
        self.marketCapRank = marketCapRank
    }
}
