//
//  DetailCoinViewModel.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 15/06/26.
//

import Foundation
internal import Combine

@MainActor
class DetailCoinViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var detailCoinViewModel: CoinViewModel?
    
    @Published var chartPoints: [ChartDataPoint] = []
    //@Published var candles: [CandleModel] = []
    
    private let cryptoCoinRepository: CryptoCoinRepositoryProtocol = CryptoCoinRepository()
    
    func loadCoinDetail(id: String) async -> Void {
        isLoading = true
        errorMessage = ""
        
        do {
            let coinDetail = try await cryptoCoinRepository.getCoinDetail(id: id)
            let points = try await cryptoCoinRepository.getChart(id: id)
            
            chartPoints = points
            detailCoinViewModel = CoinViewModel(cryptoCoinDetail: coinDetail)
        } catch {
            errorMessage = error.localizedDescription
            
        }
        isLoading = false
    }
}

class CoinViewModel {
    let cryptoCoinDetail: CryptoCoinDetailResponse

    init(cryptoCoinDetail: CryptoCoinDetailResponse) {
        self.cryptoCoinDetail = cryptoCoinDetail
    }

    // MARK: - Identidade

    var id: String      { cryptoCoinDetail.id }
    var symbol: String  { cryptoCoinDetail.symbol.uppercased() }
    var name: String    { cryptoCoinDetail.name }
    var imageURL: URL?  { URL(string: cryptoCoinDetail.image.large) }

    // MARK: - Preço

    var currentPrice: String {
        formatCurrency(cryptoCoinDetail.marketData.currentPrice["brl"])  // ← brl
    }

    var priceChange24h: String {
        let pct  = cryptoCoinDetail.marketData.priceChangePercentage24h
        let sign = pct >= 0 ? "+" : ""
        return "\(sign)\(String(format: "%.2f", pct).replacingOccurrences(of: ".", with: ","))%"
    }

    var isPriceUp: Bool {
        cryptoCoinDetail.marketData.priceChangePercentage24h >= 0
    }

    // MARK: - Informações de Mercado

    var marketCap: String {
        formatCompact(cryptoCoinDetail.marketData.marketCap["brl"])        // ← brl
    }

    var circulatingSupply: String {
        formatNumber(cryptoCoinDetail.marketData.circulatingSupply)
    }

    var maxSupply: String {
        guard let supply = cryptoCoinDetail.marketData.maxSupply else { return "∞" }
        return formatNumber(supply)
    }

    var totalSupply: String {
        guard let supply = cryptoCoinDetail.marketData.totalSupply else { return "--" }
        return formatNumber(supply)
    }

    var ath: String {
        formatCurrency(cryptoCoinDetail.marketData.ath["brl"])             // ← brl
    }

    var atl: String {
        formatCurrency(cryptoCoinDetail.marketData.atl["brl"])             // ← brl
    }

    // MARK: - Formatters pt-BR

    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle         = .currency
        f.currencyCode        = "BRL"
        f.locale              = Locale(identifier: "pt_BR")
        f.maximumFractionDigits = 2
        f.minimumFractionDigits = 2
        return f
    }()

    private var decimalFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle           = .decimal
        f.locale                = Locale(identifier: "pt_BR")
        f.maximumFractionDigits = 0
        return f
    }()

    private func formatCurrency(_ value: Double?) -> String {
        guard let value else { return "--" }
        // Para valores pequenos, mostra mais casas decimais
        if value < 1 {
            currencyFormatter.maximumFractionDigits = 6
            currencyFormatter.minimumFractionDigits = 6
        } else {
            currencyFormatter.maximumFractionDigits = 2
            currencyFormatter.minimumFractionDigits = 2
        }
        return currencyFormatter.string(from: NSNumber(value: value)) ?? "R$ \(value)"
    }

    private func formatCompact(_ value: Double?) -> String {
        guard let value else { return "--" }
        switch value {
        case 1_000_000_000_000...: return String(format: "R$ %.2f tri", value / 1_000_000_000_000)
                                          .replacingOccurrences(of: ".", with: ",")
        case 1_000_000_000...:     return String(format: "R$ %.2f bi", value / 1_000_000_000)
                                          .replacingOccurrences(of: ".", with: ",")
        case 1_000_000...:         return String(format: "R$ %.2f mi", value / 1_000_000)
                                          .replacingOccurrences(of: ".", with: ",")
        default:
            return currencyFormatter.string(from: NSNumber(value: value)) ?? "R$ \(value)"
        }
    }

    private func formatNumber(_ value: Double) -> String {
        decimalFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
