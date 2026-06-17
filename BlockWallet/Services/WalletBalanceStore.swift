import Foundation
internal import Combine

@MainActor
final class WalletBalanceStore: ObservableObject {
    static let shared = WalletBalanceStore()

    @Published var balance: Double? = nil
    @Published var usdToBrl: Double? = nil
    @Published var showBRL: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let coinService: CryptoCoinService
    private let userService: UserService

    init(
        coinService: CryptoCoinService = .shared,
        userService: UserService = UserService()
    ) {
        self.coinService = coinService
        self.userService = userService
    }

    var formattedBalance: String {
        guard let usd = balance else {
            return isLoading ? "Carregando..." : "--"
        }
        if showBRL, let rate = usdToBrl {
            return String(format: "R$ %.2f", usd * rate)
        }
        return String(format: "$ %.2f", usd)
    }

    var currencySymbol: String {
        showBRL ? "R$" : "$"
    }

    func refresh() async {
        if isLoading { return }
        isLoading = true

        do {
            let accessToken = try userService.validAccessToken()
            print("[WalletBalanceStore] Buscando saldo...")
            balance = try await coinService.getDashboardBalance(accessToken: accessToken)
            print("[WalletBalanceStore] Saldo: \(balance ?? 0)")
            errorMessage = nil
        } catch UserServiceError.tokenExpired {
            print("[WalletBalanceStore] Token expirado")
            errorMessage = "Sua sessão expirou. Faça login novamente."
        } catch {
            print("[WalletBalanceStore] Erro ao buscar saldo: \(error)")
            errorMessage = "Não foi possível atualizar o saldo da carteira."
        }

        isLoading = false

        // Busca taxa de câmbio separadamente — não bloqueia exibição do saldo
        await refreshBRLRate()
    }

    func refreshBRLRate() async {
        do {
            guard let url = URL(string: "\(Constants.API_URL)/api/v1/coins/price/simple?ids=usd-coin&vs_currencies=brl") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(ResponseData<[String: [String: Double]]>.self, from: data)
            if let rate = decoded.data["usd-coin"]?["brl"] {
                usdToBrl = rate
                print("[WalletBalanceStore] 1 USD = R$ \(rate)")
            }
        } catch {
            print("[WalletBalanceStore] Erro ao buscar taxa BRL: \(error)")
        }
    }
}
