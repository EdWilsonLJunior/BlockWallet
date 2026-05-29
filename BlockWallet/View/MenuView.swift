//
//  MenuView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 29/05/26.
//

import SwiftUI

struct MenuView: View {
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                // Title
                Text("Menu")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                // Wallet Header
                WalletHeaderView()
                
                // Menu Items
                VStack(spacing: 20) {
                    MenuItem(icon: "creditcard", title: "Add payment method")
                    MenuItem(icon: "list.bullet", title: "Activity log")
                    MenuItem(icon: "gearshape", title: "General")
                    MenuItem(icon: "sun.max", title: "Preferences")
                    MenuItem(icon: "key", title: "Security/ Privacy")
                    MenuItem(icon: "bell", title: "Push notification")
                    MenuItem(icon: "info.circle", title: "About")
                    MenuItem(icon: "questionmark.circle", title: "Help")
                }
                
                Divider()
                    .background(Color.gray.opacity(0.4))
                
                // Logout
                MenuItem(icon: "arrow.backward.circle", title: "Log Out", isDestructive: true)
                
                Spacer()
                
                BottomBarView() // reutilizado
            }
            .padding()
        }
    }
}

#Preview {
    MenuView()
}
