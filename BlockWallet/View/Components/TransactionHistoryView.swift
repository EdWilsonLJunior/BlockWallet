import SwiftUI

struct TransactionHistoryView: View {
    let filter: TransactionFilter

    @Environment(\.dismiss) private var dismiss

    private var transactions: [Transaction] {
        switch filter {
        case .all:  return Transaction.mockData
        case .buy:  return Transaction.mockData.filter { $0.type == .buy }
        case .sell: return Transaction.mockData.filter { $0.type == .sell }
        }
    }

    var body: some View {
        ZStack {
            AppGradient.primary.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Histórico")
                        .foregroundColor(.white)
                        .font(.headline)

                    Spacer()

                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                }
                .padding()

                // Filter pills
                HStack(spacing: 12) {
                    ForEach([TransactionFilter.all, .buy, .sell]) { option in
                        Text(option.rawValue)
                            .font(.caption)
                            .foregroundColor(filter == option ? .black : .white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 6)
                            .background(filter == option ? Color.white : Color.white.opacity(0.12))
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 12)

                Divider().background(Color.white.opacity(0.15))

                if transactions.isEmpty {
                    Spacer()
                    Text("Nenhuma transação encontrada.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(transactions) { tx in
                                TransactionRow(transaction: tx)
                                Divider().background(Color.white.opacity(0.1))
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Row

private struct TransactionRow: View {
    let transaction: Transaction

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .short
        f.locale = Locale(identifier: "pt_BR")
        return f
    }()

    var body: some View {
        HStack(spacing: 14) {
            // Type badge
            ZStack {
                Circle()
                    .fill(transaction.type == .buy ? Color.green.opacity(0.18) : Color.red.opacity(0.18))
                    .frame(width: 44, height: 44)
                Image(systemName: transaction.type == .buy ? "arrow.down" : "arrow.up")
                    .foregroundColor(transaction.type == .buy ? .green : .red)
                    .font(.system(size: 16, weight: .semibold))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.coinName)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(Self.dateFormatter.string(from: transaction.date))
                    .foregroundColor(.gray)
                    .font(.caption)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("\(transaction.amount, specifier: "%.4f") \(transaction.coinSymbol.uppercased())")
                    .foregroundColor(.white)
                    .font(.subheadline)
                Text(transaction.total, format: .currency(code: "BRL"))
                    .foregroundColor(transaction.type == .buy ? .green : .red)
                    .font(.caption)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 14)
    }
}

#Preview {
    TransactionHistoryView(filter: .all)
}
