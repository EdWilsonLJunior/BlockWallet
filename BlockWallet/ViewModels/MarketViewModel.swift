import Foundation
internal import Combine

@MainActor
final class MarketViewModel: ObservableObject {
    static let shared = MarketViewModel()

    @Published var cryptoCard: [CryptoCardViewModel] = []
    @Published var errorMessage: String?

    private let repository: CryptoCoinRepositoryProtocol = CryptoCoinRepository()

    func load() async {
        guard cryptoCard.isEmpty else { return }
        do {
            let coins = try await repository.getCoins(limit: 50)
            cryptoCard = coins.map(CryptoCardViewModel.init)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
