//
//  WalletHeaderView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 29/05/26.
//

import SwiftUI

struct WalletHeaderView: View {
    
    var body: some View {
        HStack(spacing: 16) {
            
            Circle()
                .fill(Color.orange)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Wallet")
                    .foregroundColor(.white)
                    .font(.headline)
                
                HStack(spacing: 6) {
                    Text("0xsdhsuu...disjd2d")
                        .foregroundColor(.gray)
                        .font(.caption)
                    
                    Image(systemName: "doc.on.doc")
                        .foregroundColor(.blue)
                }
            }
            
            Spacer()
            
            // reutilizando PrimaryButton (adaptado)
            PrimaryButtonSmall(title: "Edit")
        }
    }
}

#Preview {
    WalletHeaderView()
}
