import Foundation
internal import Combine

@MainActor
final class SwapViewModel: ObservableObject {

    enum TradeSide: String, CaseIterable, Identifiable {
        case buy
        case sell

        var id: String { rawValue }

        var title: String {
            switch self {
            case .buy:
                return "Compra"
            case .sell:
                return "Venda"
            }
        }
    }

    @Published var coins: [CryptoCoin] = []
    @Published var selectedCoin: CryptoCoin?
    @Published var quantityText: String = ""
    @Published var currentPrice: Double?
    @Published var isLoading: Bool = false
    @Published var isBuying: Bool = false
    @Published var successMessage: String?
    @Published var errorMessage: String?
    @Published var tradeSide: TradeSide = .buy

    private let repository: CryptoCoinRepositoryProtocol
    private let coinService: CryptoCoinService
    private let userService: UserService
    private let walletBalanceStore: WalletBalanceStore

    init(
        repository: CryptoCoinRepositoryProtocol = CryptoCoinRepository(),
        coinService: CryptoCoinService = .shared,
        userService: UserService = UserService(),
        walletBalanceStore: WalletBalanceStore = .shared
    ) {
        self.repository = repository
        self.coinService = coinService
        self.userService = userService
        self.walletBalanceStore = walletBalanceStore
    }

    var actionButtonTitle: String {
        if isBuying {
            return tradeSide == .buy ? "Comprando..." : "Vendendo..."
        }
        return tradeSide == .buy ? "Comprar" : "Vender"
    }

    var selectedSymbol: String {
        selectedCoin?.symbol.uppercased() ?? ""
    }

    var quantityHint: String {
        guard let symbol = selectedCoin?.symbol.uppercased() else {
            return "Selecione uma moeda"
        }
        return "Quantidade em \(symbol)"
    }

    var totalEstimateText: String {
        guard let quantity = parsedQuantity, let price = currentPrice else {
            return "--"
        }
        return String(format: "$ %.2f", quantity * price)
    }

    var rateText: String {
        guard let symbol = selectedCoin?.symbol.uppercased(), let price = currentPrice else {
            return "Cotação indisponível"
        }
        return String(format: "1 %@ ≈ $ %.2f", symbol, price)
    }

    func loadInitialData() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let items = try await repository.getCoins(limit: 50)
            let mappedCoins = items.map(CryptoCoin.from)
            coins = mappedCoins

            if selectedCoin == nil {
                selectedCoin = mappedCoins.first
            }

            await refreshPrice()
        } catch {
            errorMessage = "Não foi possível carregar as moedas."
        }
    }

    func selectCoin(_ coin: CryptoCoin) async {
        selectedCoin = coin
        await refreshPrice()
    }

    func refreshPrice() async {
        guard let coinId = selectedCoin?.id else { return }
        print("[SwapViewModel] Buscando cotação de \(coinId)...")
        do {
            currentPrice = try await coinService.getSimplePrice(coinId: coinId)
            print("[SwapViewModel] Cotação recebida: \(currentPrice ?? 0)")
        } catch {
            currentPrice = nil
            print("[SwapViewModel] Erro ao buscar cotação de \(coinId): \(error)")
            errorMessage = "Não foi possível atualizar a cotação de \(coinId)."
        }
    }

    func executeTrade() async {
        guard let coin = selectedCoin else {
            errorMessage = "Selecione uma moeda antes de continuar."
            return
        }

        guard let quantity = parsedQuantity, quantity > 0 else {
            errorMessage = "Informe uma quantidade válida para compra."
            return
        }

        guard let price = currentPrice else {
            errorMessage = "Cotação indisponível para essa moeda."
            return
        }

        isBuying = true
        defer { isBuying = false }

        do {
            let accessToken = try userService.validAccessToken()

            print("[SwapViewModel] Iniciando \(tradeSide.rawValue) de \(quantity) \(coin.id) a $\(price)")
            // A API exige que a moeda esteja no cache do Supabase antes da transação.
            // GET /coins/:id popula esse cache se ainda não existir.
            try? await CoinGeckoService.shared.fetchCoinDetail(id: coin.id)

            let request = BuyCryptoRequest(
                cryptoId: coin.id,
                quantity: quantity,
                priceAtTransaction: price
            )

            switch tradeSide {
            case .buy:
                try await coinService.buyCrypto(request: request, accessToken: accessToken)
                print("[SwapViewModel] Compra realizada com sucesso")
                successMessage = "Compra de \(coin.symbol.uppercased()) realizada com sucesso!"
            case .sell:
                try await coinService.sellCrypto(request: request, accessToken: accessToken)
                print("[SwapViewModel] Venda realizada com sucesso")
                successMessage = "Venda de \(coin.symbol.uppercased()) realizada com sucesso!"
            }

            await walletBalanceStore.refresh()
            quantityText = ""
        } catch UserServiceError.tokenExpired {
            errorMessage = "Sua sessão expirou. Faça login novamente."
        } catch NetworkError.invalidData {
            errorMessage = "Saldo insuficiente ou moeda inválida."
        } catch NetworkError.unauthorized {
            errorMessage = "Sessão inválida. Faça login novamente."
        } catch {
            errorMessage = "Não foi possível concluir a operação: \(error.localizedDescription)"
            print("[SwapViewModel] executeTrade error: \(error)")
        }
    }

    private var parsedQuantity: Double? {
        let normalized = quantityText.replacingOccurrences(of: ",", with: ".")
        return Double(normalized)
    }
}
