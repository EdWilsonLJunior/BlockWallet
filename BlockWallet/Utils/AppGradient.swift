import SwiftUI

struct AppGradient {

    static let primary = LinearGradient(
        colors: [Color.blue.mix(with: .black, by: 0.9), Color.blue.mix(with: .black, by: 0.7)],
        startPoint: .top,
        endPoint: .bottom
    )

}
