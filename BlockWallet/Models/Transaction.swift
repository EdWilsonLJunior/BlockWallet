import Foundation

enum TransactionType: String {
    case buy = "Comprado"
    case sell = "Vendido"
}

enum TransactionFilter: String, Identifiable {
    case all = "Todos"
    case buy = "Comprado"
    case sell = "Vendido"

    var id: String { rawValue }
}

struct Transaction: Identifiable {
    let id: UUID
    let type: TransactionType
    let coinName: String
    let coinSymbol: String
    let amount: Double
    let price: Double
    let date: Date

    var total: Double { amount * price }
}

extension Transaction {
    static let mockData: [Transaction] = [
        Transaction(id: UUID(), type: .buy,  coinName: "Bitcoin",  coinSymbol: "BTC", amount: 0.05, price: 300_000, date: .now.addingTimeInterval(-86400 * 0)),
        Transaction(id: UUID(), type: .sell, coinName: "Ethereum", coinSymbol: "ETH", amount: 1.2,  price: 15_000,  date: .now.addingTimeInterval(-86400 * 1)),
        Transaction(id: UUID(), type: .buy,  coinName: "Solana",   coinSymbol: "SOL", amount: 10,   price: 800,     date: .now.addingTimeInterval(-86400 * 2)),
        Transaction(id: UUID(), type: .sell, coinName: "Bitcoin",  coinSymbol: "BTC", amount: 0.02, price: 295_000, date: .now.addingTimeInterval(-86400 * 3)),
        Transaction(id: UUID(), type: .buy,  coinName: "Ethereum", coinSymbol: "ETH", amount: 0.5,  price: 14_500,  date: .now.addingTimeInterval(-86400 * 4)),
        Transaction(id: UUID(), type: .sell, coinName: "Solana",   coinSymbol: "SOL", amount: 5,    price: 780,     date: .now.addingTimeInterval(-86400 * 5)),
        Transaction(id: UUID(), type: .buy,  coinName: "Bitcoin",  coinSymbol: "BTC", amount: 0.1,  price: 310_000, date: .now.addingTimeInterval(-86400 * 6)),
    ]
}
