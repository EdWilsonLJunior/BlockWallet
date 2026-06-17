import Foundation

struct SearchCoinsResponse: Decodable {
    let coins: [SearchCoinItem]
}

struct SearchCoinItem: Decodable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String?
    let marketCapRank: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case thumb
        case marketCapRank = "market_cap_rank"
    }
}
