//
//  User.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 29/05/26.
//

import Foundation
import SwiftData

struct User: Codable {
    var id: String?
    var displayName: String
    var password: String
    var email: String
}
