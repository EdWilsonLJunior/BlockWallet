import Foundation
internal import Combine

@MainActor
final class AssetsViewModel: ObservableObject {
    static let shared = AssetsViewModel()

    @Published var holdings: [WalletHoldingResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let coinService = CryptoCoinService.shared
    private let userService = UserService()

    func load(force: Bool = false) async {
        guard force || holdings.isEmpty else { return }
        isLoading = true
        errorMessage = nil

        do {
            let token = try userService.validAccessToken()
            holdings = try await coinService.getWalletHoldings(accessToken: token)
            print("[AssetsViewModel] \(holdings.count) ativos carregados")
        } catch UserServiceError.tokenExpired {
            errorMessage = "Sua sessão expirou. Faça login novamente."
        } catch {
            print("[AssetsViewModel] Erro: \(error)")
            errorMessage = "Não foi possível carregar a carteira."
        }

        isLoading = false
    }
}
