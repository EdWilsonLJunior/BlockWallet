import SwiftUI

struct SwapView: View {
    
    @State private var payAmount: String = ""
    @State private var receiveAmount: String = ""
    @State private var showSwapModal = false
    @State private var showCoinSelector = false
    @State private var selectedCoin = "BTC"
    @State private var selectedDestinyCoin = "ETH"
    
    func swapValues() {
        let temp = payAmount
        payAmount = receiveAmount
        receiveAmount = temp
    }
    
    let mockCoins: [CryptoCoin] = [
        CryptoCoin(
            id: "bitcoin",
            name: "Bitcoin",
            symbol: "btc",
            currentPrive: "$29,000",
            priceChangePercentege24h: "2.5%",
            image: "btc", // ou URL
            marketCapRank: "1"
        ),
        CryptoCoin(
            id: "ethereum",
            name: "Ethereum",
            symbol: "eth",
            currentPrive: "$1,800",
            priceChangePercentege24h: "-1.2%",
            image: "eth",
            marketCapRank: "2"
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // Header
                Text("Swap")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer().frame(height: 10)
                
                // YOU PAY
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("You Pay")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                    AmountField(
                        value: $payAmount,
                        coin: selectedCoin,
                        icon: "bitcoinsign.circle"
                    ) {
                        showCoinSelector = true
                    }
                    
                    Text("Balance: 100 BTC")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                // Swap Button (invert)
                Button {
                    swapValues()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                
                // YOU RECEIVE
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("You Receive")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                    
                    AmountField(
                        value: $receiveAmount,
                        coin: selectedDestinyCoin,
                        icon: "circle.hexagongrid.fill"
                    ) {
                        showCoinSelector = true
                    }
                    
                    Text("Balance: 100 BTC")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                // Rate
                Text("1 BTC ≈ 1000 ETH")
                    .foregroundColor(.gray)
                    .font(.footnote)
                
                Spacer()
                
                // Swap Button
                PrimaryButton(title: "Swap") {
                    showSwapModal = true
                }
                
                Spacer()
                
                BottomBarView()
            }
            .padding()
            .background(Color.black.ignoresSafeArea())
            .sheet(isPresented: $showSwapModal) {
                SwapConfirmView()
            }
            .sheet(isPresented: $showCoinSelector) {
                SelectTokenView(coins: mockCoins) { selected in
                    selectedCoin = selected.symbol
                    showCoinSelector = false
                }
            }

        }
    }
    
}

#Preview {
    SwapView()
}
