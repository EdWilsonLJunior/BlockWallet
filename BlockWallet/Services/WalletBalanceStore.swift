import Foundation
internal import Combine

@MainActor
final class WalletBalanceStore: ObservableObject {
    static let shared = WalletBalanceStore()

    @Published var balance: Double? = nil
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
        guard let value = balance else {
            return isLoading ? "Carregando..." : "--"
        }
        return String(format: "R$ %.2f", value)
    }

    func refresh() async {
        if isLoading { return }
        isLoading = true

        do {
            let accessToken = try userService.validAccessToken()
            balance = try await coinService.getDashboardBalance(accessToken: accessToken)
            errorMessage = nil
        } catch UserServiceError.tokenExpired {
            errorMessage = "Sua sessão expirou. Faça login novamente."
        } catch {
            errorMessage = "Não foi possível atualizar o saldo da carteira."
        }

        isLoading = false
    }
}
