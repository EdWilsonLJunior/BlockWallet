import SwiftUI

struct TopMoversView: View {
    
    let cryptoCard: [CryptoCardViewModel]
    @Binding var title: String
    @Binding var textButton: String
    
    @State private var showAll: Bool = false
    
    private var displayedCoins: [CryptoCardViewModel] {
        showAll ? cryptoCard : Array(cryptoCard.prefix(6))
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showAll.toggle()
                    }
                } label: {
                    Text(showAll ? "Ver Menos" : textButton)
                        .foregroundColor(.blue)
                        .font(.caption)
                        .padding()
                }
            }
            
            LazyVGrid(columns: columns, spacing: 16 ) {
                ForEach(displayedCoins, id: \.id) { coin in
                    HStack(spacing: 8) {
                        NavigationLink {
                            DetailCoin()
                        } label: {
                            CoinCard(
                                symbol: coin.symbol,
                                name: coin.name,
                                change: "\(coin.change)",
                                image: coin.image
                            )
                        }
                    }
                }
            }
        }
    }
}

struct CoinCard: View {
    let symbol: String
    let name: String
    let change: String    
    let image: String
    let color: Color?
    
    init(symbol: String, name: String, change: String, image: String, color: Color? = nil) {
        self.symbol = symbol
        self.name = name
        self.change = change
        self.image = image
        self.color = color
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                AsyncImage(url: URL(string: image)) { image in
                    image.image?.resizable()
                        .scaledToFill()
                }
                .frame(width: 20, height: 20)
                
                Text(symbol)
                    .foregroundColor(.white)
                    .bold()
                
                Spacer()
                
                Text(change)
                    .font(.caption)
                    .padding(6)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(8)
            }
            
            Text(name)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

#Preview {
    
    @Previewable @State var title: String = "Destaques"
    @Previewable @State var textButton: String = "Ver Todos"
    
    let cryptoCards = [
        CryptoCardViewModel(cryptoCoin: CryptoCoinResponse(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            currentPrice: 1666.27,
            priceChangePercentage24h: -0.67301
        )),
        CryptoCardViewModel(cryptoCoin: CryptoCoinResponse(
            id: "ethereum",
            symbol: "eth",
            name: "Ethereum",
            image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
            currentPrice: 1666.27,
            priceChangePercentage24h: -0.66051
        )),
        CryptoCardViewModel(cryptoCoin: CryptoCoinResponse(
            id: "solana",
            symbol: "eth",
            name: "Ethereum",
            image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
            currentPrice: 1666.27,
            priceChangePercentage24h: -0.66051
        ))
    ]
    
    TopMoversView(cryptoCard: cryptoCards, title: $title, textButton: $textButton)
}
