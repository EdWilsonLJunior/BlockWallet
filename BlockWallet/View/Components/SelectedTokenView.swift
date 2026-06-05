import SwiftUI

struct SelectTokenView: View {
    
    var coins: [CryptoCoin]
    var onSelect: (CryptoCoin) -> Void
    
    @State private var search: String = ""
    
    var filteredCoins: [CryptoCoin] {
        coins.filter {
            search.isEmpty ||
            $0.symbol.lowercased().contains(search.lowercased()) ||
            $0.name.lowercased().contains(search.lowercased())
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            // Drag indicator
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 4)
                .padding(.top, 8)
            
            Text("Select Token")
                .foregroundColor(.white)
                .font(.headline)
            
            // Search
            HStack {
                TextField("Search token", text: $search)
                    .foregroundColor(.white)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(12)
            
            // Lista
            ScrollView {
                VStack(spacing: 16) {
                    
                    ForEach(filteredCoins) { coin in
                        
                        Button {
                            onSelect(coin)
                        } label: {
                            HStack(spacing: 12) {
                                
                                if UIImage(named: coin.image) != nil {
                                    Image(coin.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                } else if let url = URL(string: coin.image) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 40, height: 40)
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Image(systemName: "questionmark")
                                                .foregroundColor(.white)
                                        )
                                }
                                
                                // Nome + símbolo
                                VStack(alignment: .leading) {
                                    Text(coin.symbol.uppercased())
                                        .foregroundColor(.white)
                                        .bold()
                                    
                                    Text(coin.name)
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                
                                Spacer()
                                
                                // Preço + Market Rank
                                VStack(alignment: .trailing) {
                                    Text(coin.currentPrive)
                                        .foregroundColor(.white)
                                    
                                    Text("#\(coin.marketCapRank)")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                            }
                        }
                        
                        Divider()
                            .background(Color.gray.opacity(0.3))
                    }
                }
            }
        }
        .padding()
        .background(Color.black.ignoresSafeArea())
    }
}
