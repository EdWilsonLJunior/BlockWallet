//
//  ChartDataPoint.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 16/06/26.
//

import Foundation

extension ChartDataPoint {
    static func mock() -> [ChartDataPoint] {
        var price = 65000.0
        return (0..<20).map { i in
            price += Double.random(in: -800...800)
            return ChartDataPoint(
                timestamp: Date().addingTimeInterval(Double(i) * -3600),
                price: price
            )
        }.reversed()
    }
}
