//
//  RegisterViewModel.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 08/06/26.
//

import Foundation
internal import Combine

class RegisterViewModel: ObservableObject {
    
    let userService: UserService = UserService()
    
    func register(userName: String, email: String, password: String) async -> Bool {
        let user = User(displayName: userName, password: password, email: email)
         
        do {
            return try await userService.create(user: user)
        } catch {
            return false;
        }
        
    }
}
