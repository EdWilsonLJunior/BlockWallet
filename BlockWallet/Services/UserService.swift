//
//  UserService.swift
//  BlockWallet
//
//  Created by Sales, Wyllian Fonseca on 08/06/26.
//

import Foundation

enum UserServiceError: Error {
    case invalidData
    case invalidURL
    case netWorkError
    case success
}

class UserService {
    
    func login() {
        
    }
    
    func create(user: User) async throws -> Bool {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/auth/sign-up") else {
            throw UserServiceError.invalidData
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
        do {
            request.httpBody = try JSONEncoder().encode(user)
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                throw UserServiceError.invalidData
            }
                        
            return true;
        } catch {
            throw UserServiceError.netWorkError
        }
    }
}
