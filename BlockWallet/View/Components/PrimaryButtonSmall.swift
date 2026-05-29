//
//  PrimaryButtonSmall.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 29/05/26.
//

import SwiftUI

struct PrimaryButtonSmall: View {
    let title: String
    
    var body: some View {
        Button(action: {}) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(20)
        }
    }
}


#Preview {
    PrimaryButtonSmall(title: "Tittle")
}
