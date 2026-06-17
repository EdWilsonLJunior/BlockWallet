import Foundation

struct CoinChartResponse: Codable {
    let success: Bool
    let data: ChartData
}

struct ChartData: Codable {
    let prices: [[Double]]
    let marketCaps: [[Double]]
    let totalVolumes: [[Double]]

    enum CodingKeys: String, CodingKey {
        case prices
        case marketCaps   = "market_caps"
        case totalVolumes = "total_volumes"
    }
}

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let timestamp: Date
    let price: Double
}
