import SwiftUI


struct ActionsView: View {
    @State private var historyFilter: TransactionFilter? = nil

    var body: some View {
        HStack(spacing: 40) {
            ActionItem(icon: "arrow.up", title: "Vendido") {
                historyFilter = .sell
            }
            ActionItem(icon: "arrow.down", title: "Comprado") {
                historyFilter = .buy
            }
            ActionItem(icon: "arrow.left.arrow.right", title: "Todos") {
                historyFilter = .all
            }
        }
        .sheet(item: $historyFilter) { filter in
            TransactionHistoryView(filter: filter)
        }
    }
}

struct ActionItem: View {
    let icon: String
    let title: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: 60, height: 60)

                    Image(systemName: icon)
                        .foregroundColor(.blue)
                }

                Text(title)
                    .foregroundColor(.white)
                    .font(.footnote)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ActionsView()
}
