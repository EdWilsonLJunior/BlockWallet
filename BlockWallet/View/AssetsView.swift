import SwiftUI

// MARK: - Wallet Asset Row

private struct WalletAssetRow: View {

    let holding: WalletHoldingResponse

    private var coinIcon: some View {
        AsyncImage(url: URL(string: holding.imageUrl ?? "")) { phase in
            if let img = phase.image {
                img.resizable().scaledToFill()
            } else {
                ZStack {
                    Circle().fill(Color.gray.opacity(0.3))
                    Text((holding.cryptoSymbol ?? holding.cryptoId).prefix(2).uppercased())
                        .foregroundColor(.white)
                        .font(.caption2).bold()
                }
            }
        }
        .frame(width: 44, height: 44)
        .clipShape(Circle())
    }

    private var symbol: String {
        (holding.cryptoSymbol ?? holding.cryptoId).uppercased()
    }

    var body: some View {
        HStack(spacing: 14) {
            coinIcon

            VStack(alignment: .leading, spacing: 4) {
                Text(symbol)
                    .foregroundColor(.white)
                    .font(.subheadline).bold()
                Text(String(format: "%.6g %@", holding.totalQuantity, symbol))
                    .foregroundColor(.gray)
                    .font(.caption)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                if let value = holding.currentValueUsd {
                    Text(String(format: "R$ %.2f", value))
                        .foregroundColor(.white)
                        .font(.subheadline).bold()
                } else if let invested = holding.totalInvestedUsd {
                    Text(String(format: "R$ %.2f", invested))
                        .foregroundColor(.white)
                        .font(.subheadline).bold()
                } else {
                    Text("--")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }

                if let avg = holding.averageBuyPrice {
                    Text(String(format: "Preço médio: R$ %.2f", avg))
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

// MARK: - AssetsView

struct AssetsView: View {

    @StateObject private var viewModel = AssetsViewModel.shared

    var body: some View {
        ZStack {
            AppGradient.primary.ignoresSafeArea()

            VStack(spacing: 20) {

                HeaderView()

                BalanceView()

                ActionsView()

                // Lista de Ativos
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Meus Ativos")
                            .foregroundColor(.white)
                            .font(.headline)
                        Spacer()
                        if !viewModel.holdings.isEmpty {
                            Text("\(viewModel.holdings.count) moeda\(viewModel.holdings.count == 1 ? "" : "s")")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        Button {
                            Task { await viewModel.load(force: true) }
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }

                    if viewModel.isLoading {
                        HStack { Spacer(); ProgressView().tint(.white); Spacer() }
                            .padding(.vertical, 40)
                    } else if let error = viewModel.errorMessage {
                        VStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                                .font(.title2)
                            Text(error)
                                .foregroundColor(.gray)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 30)
                    } else if viewModel.holdings.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "wallet.bifold")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("Nenhum ativo na carteira")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(viewModel.holdings, id: \.cryptoId) { holding in
                                    WalletAssetRow(holding: holding)
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .task { await viewModel.load() }
    }
}

#Preview {
    AssetsView()
}

