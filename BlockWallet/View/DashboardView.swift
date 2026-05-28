//
//  Dashboard.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 28/05/26.
//

import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                HeaderView()
                
                BalanceView()
                
                ActionsView()
                
                BuyCryptoCard()
                
                TopMoversView()
                
                Spacer()
                
                BottomBarView()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView()
}
