import Foundation

enum UserServiceError: Error {
    case invalidData
    case invalidURL
    case netWorkError
    case tokenExpired
    case success
}

class UserService {

    func login(email: String, password: String) async throws -> LoginData {
        guard let url = URL(string: "\(Constants.API_URL)/api/v1/auth/sign-in") else {
            throw UserServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let loginRequest = LoginRequest(email: email, password: password)
            request.httpBody = try JSONEncoder().encode(loginRequest)

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw UserServiceError.netWorkError
            }

            guard httpResponse.statusCode == 200 else {
                throw UserServiceError.invalidData
            }

            let decoded = try JSONDecoder().decode(ResponseData<LoginData>.self, from: data)
            let loginData = decoded.data

            KeychainService.saveTokens(
                accessToken: loginData.accessToken,
                refreshToken: loginData.refreshToken,
                expiresAt: loginData.expiresAt
            )

            return loginData
        } catch is DecodingError {
            throw UserServiceError.invalidData
        } catch let error as UserServiceError {
            throw error
        } catch {
            throw UserServiceError.netWorkError
        }
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

            return true
        } catch {
            throw UserServiceError.netWorkError
        }
    }

    var hasValidSession: Bool {
        KeychainService.isTokenValid
    }

    func validAccessToken() throws -> String {
        guard KeychainService.isTokenValid, let token = KeychainService.accessToken else {
            KeychainService.clearTokens()
            throw UserServiceError.tokenExpired
        }
        return token
    }

    func logout() {
        KeychainService.clearTokens()
    }
}

