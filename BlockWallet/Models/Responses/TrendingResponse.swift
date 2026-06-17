import Foundation

struct TrendingResponse: Decodable {
    let coins: [TrendingCoinWrapper]
}

struct TrendingCoinWrapper: Decodable {
    let item: TrendingCoinItem
}

struct TrendingCoinItem: Decodable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let score: Int?
}
