//
//  TopMoversView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 28/05/26.
//

import SwiftUI

struct TopMoversView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text("Destaques")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
                
                Text("Ver todos")
                    .foregroundColor(.blue)
                    .font(.caption)
                    .padding()
            }
            
            HStack(spacing: 12) {
                CoinCard(name: "BTC", subtitle: "Bitcoin", change: "+4.5%", color: .orange)
                CoinCard(name: "ETH", subtitle: "Ethereum", change: "+4.5%", color: .purple)
            }
        }
    }
}

struct CoinCard: View {
    let name: String
    let subtitle: String
    let change: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Circle()
                    .fill(color)
                    .frame(width: 20, height: 20)
                
                Text(name)
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
            
            Text(subtitle)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

#Preview {
    TopMoversView()
}
