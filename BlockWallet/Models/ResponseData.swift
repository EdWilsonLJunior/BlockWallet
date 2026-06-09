//
//  Response.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 08/06/26.
//

import Foundation

struct ResponseData<T: Decodable>: Decodable {
    var success: Bool
    var data: T
    var timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case data
        case timestamp
    }
}
