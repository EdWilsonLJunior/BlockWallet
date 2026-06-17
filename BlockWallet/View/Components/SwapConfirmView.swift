//
//  SwapConfirmView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 05/06/26.
//

import SwiftUI

struct SwapConfirmView: View {
    
    var body: some View {
        VStack(spacing: 20) {

            // puxador
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 4)
                .padding(.top, 8)
            
            Text("Swap Transaction")
                .foregroundColor(.white)
                .font(.headline)

            // moedas
            HStack {
                VStack {
                    Circle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "bitcoinsign.circle")
                                .foregroundColor(.orange)
                        )
                    
                    Text("0.1298 BTC")
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("$3.00912")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                Spacer()
                
                Image(systemName: "arrow.left.arrow.right")
                    .foregroundColor(.blue)
                
                Spacer()
                
                VStack {
                    Circle()
                        .fill(Color.purple.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "circle.hexagongrid.fill")
                                .foregroundColor(.purple)
                        )
                    
                    Text("0.1642 ETH")
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("$3.00")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
            
            Divider().background(Color.gray)
            
            // detalhes
            infoRow(title: "From:", value: "0x8dfu8df8ija8289d93dj9d3...00kdiwjd")
            infoRow(title: "To:", value: "0x8dfu8df8ija8289d93dj9d3...00kdiwjd")
            
            Divider().background(Color.gray)
            
            infoRow(title: "Network fees", value: "0.004 BTC")
            infoRow(title: "Total", value: "0.1320 BTC")
            
            // alerta
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.blue)
                
                Text("Valide a transação antes de prosseguir")
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.15))
            .cornerRadius(12)
            
            Spacer()
            
            // botão confirmar
            PrimaryButton(title: "Confirmar") {
                print("Confirmado")
            }
        }
        .padding()
        .background(AppGradient.primary.ignoresSafeArea())
    }
}


#Preview {
    SwapConfirmView()
}
