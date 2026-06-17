import Foundation

struct BuyCryptoRequest: Encodable {
    let cryptoId: String
    let quantity: Double
    let priceAtTransaction: Double
}
