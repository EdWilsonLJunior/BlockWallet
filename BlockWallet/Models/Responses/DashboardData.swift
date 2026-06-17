import Foundation

struct DashboardData: Decodable {
    let simulatedBalanceUsd: Double

    enum CodingKeys: String, CodingKey {
        case simulatedBalanceUsd = "simulated_balance_usd"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let double = try? container.decode(Double.self, forKey: .simulatedBalanceUsd) {
            simulatedBalanceUsd = double
        } else if let string = try? container.decode(String.self, forKey: .simulatedBalanceUsd),
                  let double = Double(string) {
            simulatedBalanceUsd = double
        } else {
            simulatedBalanceUsd = 0
        }
    }
}
