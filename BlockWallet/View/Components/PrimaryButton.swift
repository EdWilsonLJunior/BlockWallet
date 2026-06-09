import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isDisable: Bool
    let action: () -> Void
    
    init(title: String, isDisable: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isDisable = isDisable
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Group {
                        if isDisable {
                            Color.blue.opacity(0.5)
                        } else {
                            LinearGradient(
                                colors: [Color.blue.opacity(0.8), Color.blue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        }
                    }
                )
                .cornerRadius(30)
        }
        .disabled(isDisable)
    }
}

#Preview {
    PrimaryButton(title: "Login", isDisable: true, action: {})
}
