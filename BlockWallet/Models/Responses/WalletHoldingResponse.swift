import Foundation

struct WalletHoldingResponse: Decodable {
    let cryptoId: String
    let cryptoName: String?
    let cryptoSymbol: String?
    let totalQuantity: Double
    let averageBuyPrice: Double?
    let totalInvestedUsd: Double?
    let currentValueUsd: Double?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case cryptoId          = "crypto_id"
        case cryptoName        = "crypto_name"
        case cryptoSymbol      = "crypto_symbol"
        case totalQuantity     = "total_quantity"
        case averageBuyPrice   = "average_buy_price"
        case totalInvestedUsd  = "total_invested_usd"
        case currentValueUsd   = "current_value_usd"
        case imageUrl          = "image_url"
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        cryptoId       = try c.decode(String.self, forKey: .cryptoId)
        cryptoName     = try c.decodeIfPresent(String.self, forKey: .cryptoName)
        cryptoSymbol   = try c.decodeIfPresent(String.self, forKey: .cryptoSymbol)
        imageUrl       = try c.decodeIfPresent(String.self, forKey: .imageUrl)

        // quantity pode vir como Double ou String
        if let d = try? c.decode(Double.self, forKey: .totalQuantity) {
            totalQuantity = d
        } else if let s = try? c.decode(String.self, forKey: .totalQuantity), let d = Double(s) {
            totalQuantity = d
        } else {
            totalQuantity = 0
        }

        averageBuyPrice  = Self.flexDouble(c, key: .averageBuyPrice)
        totalInvestedUsd = Self.flexDouble(c, key: .totalInvestedUsd)
        currentValueUsd  = Self.flexDouble(c, key: .currentValueUsd)
    }

    private static func flexDouble(_ c: KeyedDecodingContainer<CodingKeys>, key: CodingKeys) -> Double? {
        if let d = try? c.decodeIfPresent(Double.self, forKey: key) { return d }
        if let s = try? c.decodeIfPresent(String.self, forKey: key) { return Double(s) }
        return nil
    }
}
