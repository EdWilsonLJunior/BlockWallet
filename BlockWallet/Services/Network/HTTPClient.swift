import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

enum HTTPClientError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int, message: String?)
    case rateLimited
    case decodingError
}

final class HTTPClient {
    static let shared = HTTPClient()

    private let session: URLSession
    private let limiter: RateLimiter
    private let executionQueue: RequestExecutionQueue

    init(
        session: URLSession? = nil,
        limiter: RateLimiter = RateLimiter(maxRequestsPerMinute: 100),
        executionQueue: RequestExecutionQueue = .shared
    ) {
        if let session {
            self.session = session
        } else {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 10
            configuration.timeoutIntervalForResource = 10
            self.session = URLSession(configuration: configuration)
        }
        self.limiter = limiter
        self.executionQueue = executionQueue
    }

    func request<T: Decodable>(
        path: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: Data? = nil,
        decode type: T.Type
    ) async throws -> T {
        let data = try await requestData(
            path: path,
            method: method,
            queryItems: queryItems,
            headers: headers,
            body: body
        )

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw HTTPClientError.decodingError
        }
    }

    func requestData(
        path: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:],
        body: Data? = nil
    ) async throws -> Data {
        guard var components = URLComponents(string: "\(Constants.API_URL)\(path)") else {
            throw HTTPClientError.invalidURL
        }

        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw HTTPClientError.invalidURL
        }

        return try await performWithRetry(
            retries: 3,
            initialDelaySeconds: 1
        ) {
            await self.limiter.awaitPermit()

            return try await self.executionQueue.run {
                var request = URLRequest(url: url)
                request.httpMethod = method.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                headers.forEach { key, value in
                    request.setValue(value, forHTTPHeaderField: key)
                }
                request.httpBody = body

                let (data, response) = try await self.session.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HTTPClientError.invalidResponse
                }

                if httpResponse.statusCode == 429 {
                    throw HTTPClientError.rateLimited
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    let message = String(data: data, encoding: .utf8)
                    throw HTTPClientError.requestFailed(statusCode: httpResponse.statusCode, message: message)
                }

                return data
            }
        }
    }

    private func performWithRetry<T>(
        retries: Int,
        initialDelaySeconds: TimeInterval,
        operation: @escaping () async throws -> T
    ) async throws -> T {
        var currentAttempt = 0
        var currentDelay = initialDelaySeconds

        while true {
            do {
                return try await operation()
            } catch let error as HTTPClientError {
                if case .rateLimited = error {
                    throw error
                }
                if currentAttempt >= retries {
                    throw error
                }
            } catch {
                if currentAttempt >= retries {
                    throw error
                }
            }

            currentAttempt += 1
            let waitNanoseconds = UInt64(currentDelay * 1_000_000_000)
            try? await Task.sleep(nanoseconds: waitNanoseconds)
            currentDelay *= 2
        }
    }
}
