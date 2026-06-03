//
//  User.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 29/05/26.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}
