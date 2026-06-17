import Foundation

final class RequestExecutionQueue {
    static let shared = RequestExecutionQueue()

    private let queue: OperationQueue

    private init() {
        queue = OperationQueue()
        queue.name = "com.blockwallet.network.queue"
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
    }

    func run<T>(_ work: @escaping () async throws -> T) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            let operation = BlockOperation()
            operation.addExecutionBlock {
                Task {
                    do {
                        let value = try await work()
                        continuation.resume(returning: value)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            queue.addOperation(operation)
        }
    }
}
