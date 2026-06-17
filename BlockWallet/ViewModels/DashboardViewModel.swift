import Foundation
internal import Combine

@MainActor
class DashboardViewModel: ObservableObject {
    static let shared = DashboardViewModel()

    @Published var cryptoCard: [CryptoCardViewModel] = []
    @Published var errorMessage: String?
    
    private let repository: CryptoCoinRepositoryProtocol = CryptoCoinRepository()
    
    func loadCryptoCards(limit: Int) async {
        guard cryptoCard.isEmpty else { return }
        do {
            let coins = try await repository.getCoins(limit: limit)
            cryptoCard = coins.map(CryptoCardViewModel.init)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}

struct CryptoCardViewModel: Identifiable {
    var cryptoCoin: CryptoCoinResponse
    
    init(cryptoCoin: CryptoCoinResponse) {
        self.cryptoCoin = cryptoCoin
    }
    
    var id: String {
        cryptoCoin.id
    }
    
    var name: String {
        cryptoCoin.name
    }
    
    var symbol: String {
        cryptoCoin.symbol
    }
    
    var change: String {
        String(format: "%.2f%%", cryptoCoin.priceChangePercentage24h ?? 0.0)
    }
    
    var image: String {
        cryptoCoin.image ?? ""
    }
}
