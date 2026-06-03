//
//  BalanceView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 28/05/26.
//

import SwiftUI

struct BalanceView: View {
    var body: some View {
        VStack(spacing: 12) {
            
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 70, height: 70)
                
                Text("$")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }
            
            Text("$309567.55")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
            
            Text("+4.5%")
                .font(.caption)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.2))
                .foregroundColor(.blue)
                .cornerRadius(10)
        }
    }
}


#Preview {
    BalanceView()
}
