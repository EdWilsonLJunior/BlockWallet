//
//  BalanceView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 28/05/26.
//

import SwiftUI

struct BalanceView: View {
    @StateObject private var store = WalletBalanceStore.shared

    var body: some View {
        VStack(spacing: 12) {

            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 70, height: 70)

                Text(store.currencySymbol)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }

            Text(store.formattedBalance)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .redacted(reason: store.isLoading ? .placeholder : [])

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    store.showBRL.toggle()
                }
            } label: {
                Text(store.showBRL ? "Ver em USD" : "Ver em BRL")
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
            .disabled(store.usdToBrl == nil)
        }
    }
}

#Preview {
    BalanceView()
}
