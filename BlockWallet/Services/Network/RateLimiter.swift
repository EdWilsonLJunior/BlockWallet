import Foundation

actor RateLimiter {
    private let maxRequestsPerMinute: Int
    private let timeWindow: TimeInterval = 60
    private var requestTimestamps: [Date] = []

    init(maxRequestsPerMinute: Int = 60) {
        self.maxRequestsPerMinute = maxRequestsPerMinute
    }

    func awaitPermit() async {
        while true {
            let now = Date()
            requestTimestamps.removeAll { now.timeIntervalSince($0) >= timeWindow }

            if requestTimestamps.count < maxRequestsPerMinute {
                requestTimestamps.append(now)
                return
            }

            guard let oldest = requestTimestamps.first else {
                return
            }

            let waitSeconds = max(0.05, timeWindow - now.timeIntervalSince(oldest))
            let waitNanoseconds = UInt64(waitSeconds * 1_000_000_000)
            try? await Task.sleep(nanoseconds: waitNanoseconds)
        }
    }
}
