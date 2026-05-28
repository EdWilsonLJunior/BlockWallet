//
//  BottomBarView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 28/05/26.
//

import SwiftUI

struct BottomBarView: View {
    var body: some View {
        ZStack {
            
            HStack {
                BottomItem(icon: "house", title: "Home", isActive: true)
                BottomItem(icon: "chart.bar", title: "Market")
                
                Spacer()
                    .frame(width: 60)
                
                BottomItem(icon: "wallet.pass", title: "Assets")
                BottomItem(icon: "line.3.horizontal", title: "Menu")
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            Button(action: {}) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.black)
                    )
            }
            .offset(y: -25)
        }
    }
}

struct BottomItem: View {
    let icon: String
    let title: String
    var isActive: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(isActive ? .blue : .gray)
            
            Text(title)
                .font(.caption2)
                .foregroundColor(isActive ? .blue : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BottomBarView()
}
