import SwiftUI

// MARK: - Wallet Holding Model

private struct WalletHolding: Identifiable {
    let id: String
    let coinName: String
    let coinSymbol: String
    let amount: Double
    let currentPrice: Double
    let priceChange24h: Double
    let image: String

    var totalValue: Double { amount * currentPrice }
}

// MARK: - Wallet Asset Row

private struct WalletAssetRow: View {

    let holding: WalletHolding

    private var coinIcon: some View {
        AsyncImage(url: URL(string: holding.image)) { phase in
            if let img = phase.image {
                img.resizable().scaledToFill()
            } else {
                ZStack {
                    Circle().fill(Color.gray.opacity(0.3))
                    Text(holding.coinSymbol.prefix(2).uppercased())
                        .foregroundColor(.white)
                        .font(.caption2).bold()
                }
            }
        }
        .frame(width: 44, height: 44)
        .clipShape(Circle())
    }

    var body: some View {
        HStack(spacing: 14) {
            coinIcon

            VStack(alignment: .leading, spacing: 4) {
                Text(holding.coinSymbol.uppercased())
                    .foregroundColor(.white)
                    .font(.subheadline).bold()
                Text(String(format: "%.4f %@", holding.amount, holding.coinSymbol.uppercased()))
                    .foregroundColor(.gray)
                    .font(.caption)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(holding.totalValue, format: .currency(code: "BRL"))
                    .foregroundColor(.white)
                    .font(.subheadline).bold()

                HStack(spacing: 4) {
                    Image(systemName: holding.priceChange24h >= 0 ? "arrow.up.right" : "arrow.down.right")
                        .font(.caption2)
                    Text(String(format: "%.2f%%", abs(holding.priceChange24h)))
                        .font(.caption)
                }
                .foregroundColor(holding.priceChange24h >= 0 ? .green : .red)
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

// MARK: - AssetsView

struct AssetsView: View {

    // Mock de preços atuais (substituir por dados da API em produção)
    private let mockPriceMap: [String: (price: Double, change: Double, image: String)] = [
        "btc": (300_000, -0.66, "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"),
        "eth": (15_000,  1.23,  "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628"),
        "sol": (800,     2.45,  "https://coin-images.coingecko.com/coins/images/4128/large/solana.png?1696504756"),
        "bnb": (600,     0.85,  "https://coin-images.coingecko.com/coins/images/825/large/bnb-icon2_2x.png?1696501970"),
        "xrp": (3.2,    -1.10, "https://coin-images.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442"),
        "matic": (0.85,  3.20,  "https://coin-images.coingecko.com/coins/images/4713/large/polygon.png?1698233745")
    ]

    private var holdings: [WalletHolding] {
        var map: [String: (name: String, symbol: String, amount: Double)] = [:]
        for tx in Transaction.mockData {
            let key = tx.coinSymbol.lowercased()
            var entry = map[key] ?? (tx.coinName, tx.coinSymbol, 0.0)
            entry.amount += tx.type == .buy ? tx.amount : -tx.amount
            map[key] = entry
        }
        return map.values
            .filter { $0.amount > 0 }
            .map { entry in
                let price = mockPriceMap[entry.symbol.lowercased()]
                return WalletHolding(
                    id: entry.symbol,
                    coinName: entry.name,
                    coinSymbol: entry.symbol,
                    amount: entry.amount,
                    currentPrice: price?.price ?? 0,
                    priceChange24h: price?.change ?? 0,
                    image: price?.image ?? ""
                )
            }
            .sorted { $0.totalValue > $1.totalValue }
    }

    private var totalBalance: Double {
        holdings.reduce(0) { $0 + $1.totalValue }
    }

    private var totalChange: Double {
        guard !holdings.isEmpty else { return 0 }
        let weightedChange = holdings.reduce(0.0) { acc, h in
            acc + (h.totalValue / totalBalance) * h.priceChange24h
        }
        return weightedChange
    }

    var body: some View {
        ZStack {
            AppGradient.primary.ignoresSafeArea()

            VStack(spacing: 20) {
                
                HeaderView()
                
                BalanceView()
                
                ActionsView()

                // Lista de Ativos
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Meus Ativos")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                        Text("\(holdings.count) moeda\(holdings.count == 1 ? "" : "s")")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }

                    if holdings.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "wallet.bifold")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("Nenhum ativo na carteira")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(holdings) { holding in
                                    WalletAssetRow(holding: holding)
                                }
                            }
                        }
                    }
                }

                Spacer()

                BottomBarView(currentView: .assets)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AssetsView()
}
