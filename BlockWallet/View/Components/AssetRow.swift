//
//  AssetRow.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 05/06/26.
//

import SwiftUI

struct AssetRow: View {
    
    let coin: CryptoCoin
    
    var coinIcon: some View {
        Group {
            if UIImage(named: coin.image) != nil {
                Image(coin.image)
                    .resizable()
                    .scaledToFit()
            } else if let url = URL(string: coin.image) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
            }
        }
        .frame(width: 40, height: 40)
    }
    
    var body: some View {
        HStack(spacing: 12) {
            
            coinIcon
            
            VStack(alignment: .leading) {
                Text(coin.symbol.uppercased())
                    .foregroundColor(.white)
                    .bold()
                
                Text(coin.name)
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            Spacer()
            
            // ✅ GRAPH (fake)
            Image(systemName: "waveform.path.ecg")
                .foregroundColor(.green)
            
            Spacer()
            
            // ✅ PRICE
            VStack(alignment: .trailing) {
                Text("3.00912")
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    Text("($12.09)")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    Text("(+\(coin.priceChangePercentage24h))")
                        .foregroundColor(.green)
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

