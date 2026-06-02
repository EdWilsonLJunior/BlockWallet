//
//  MenuItem.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 29/05/26.
//

import SwiftUI

struct MenuItem: View {
    
    let icon: String
    let title: String
    var isDestructive: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isDestructive ? .red : .blue)
            
            Text(title)
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.blue)
        }
        .padding(.vertical, 8)
    }
}
