//
//  CoinLocalService.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 14/06/26.
//

import Foundation
import SwiftData

final class CryptoCoinLocalService {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save(coins: [CryptoCoinResponse]) {
        coins.forEach { coin in
            let cryptoCoin = CryptoCoin.from(cryptoCoinResponse: coin)
            context.insert(cryptoCoin)
        }
        
        do {
            try context.save()
        } catch {
            print("Error ao salvar moedas: \(error.localizedDescription)")
        }
    }
    
    func fetchCoins() -> [CryptoCoin] {
        let descriptor = FetchDescriptor<CryptoCoin>()
        
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Erro ao buscar no SwiftData: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteall() {
        do {
            try context.delete(model: CryptoCoin.self)
        } catch {
            print("Erro ao deletar dados: \(error.localizedDescription)")
        }
    }
}
