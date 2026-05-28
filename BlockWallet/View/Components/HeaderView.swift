//
//  HeaderView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 28/05/26.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            
            Image(systemName: "qrcode.viewfinder")
                .foregroundColor(.blue)
            
            Spacer()
            
            HStack(spacing: 6) {
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.white)
                
                Text("Carteira (0xabcioEcdjd)")
                    .foregroundColor(.white)
                    .font(.footnote)
            }
            
            Spacer()
            
            Image(systemName: "bell")
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    HeaderView()
}
