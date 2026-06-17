import SwiftUI

struct SwapView: View {

    @StateObject private var viewModel = SwapViewModel()
    @State private var showCoinSelector = false

    var body: some View {
        VStack(spacing: 24) {
                
                // Header
                Text("Swap")
                    .foregroundColor(.white)
                    .font(.headline)

                Picker("Tipo de operação", selection: $viewModel.tradeSide) {
                    ForEach(SwapViewModel.TradeSide.allCases) { side in
                        Text(side.title).tag(side)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer().frame(height: 10)
                
                // YOU PAY
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Você Paga")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                    AmountField(
                        value: $viewModel.quantityText,
                        coin: viewModel.selectedSymbol,
                        icon: "bitcoinsign.circle"
                    ) {
                        showCoinSelector = true
                    }
                    
                    Text(viewModel.quantityHint)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                // YOU RECEIVE
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Você Recebe")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                    
                    AmountField(
                                            value: .constant(viewModel.totalEstimateText),
                                            coin: "USD",
                        icon: "circle.hexagongrid.fill"
                    ) {
                                            // not selectable
                    }
                    
                                        Text("Valor estimado da compra")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                // Rate
                                    Text(viewModel.rateText)
                    .foregroundColor(.gray)
                    .font(.footnote)

                                    if viewModel.isLoading {
                                        ProgressView()
                                            .tint(.white)
                                    }
                
                Spacer()
                
                // Swap Button
                                    PrimaryButton(title: viewModel.actionButtonTitle) {
                                        Task {
                                            await viewModel.executeTrade()
                                        }
                }
                                    .disabled(viewModel.isBuying || viewModel.isLoading)
                
            }
            .padding()
            .background(AppGradient.primary.ignoresSafeArea().ignoresSafeArea())
            .sheet(isPresented: $showCoinSelector) {
                                    SelectTokenView(coins: viewModel.coins) { selected in
                                        Task {
                                            await viewModel.selectCoin(selected)
                                        }
                    showCoinSelector = false
                }
            }
                                .task {
                                    await viewModel.loadInitialData()
                                }
                                .alert("Sucesso", isPresented: Binding(
                                    get: { viewModel.successMessage != nil },
                                    set: { newValue in
                                        if !newValue {
                                            viewModel.successMessage = nil
                                        }
                                    }
                                )) {
                                    Button("OK", role: .cancel) {
                                        viewModel.successMessage = nil
                                    }
                                } message: {
                                    Text(viewModel.successMessage ?? "")
                                }
                                .alert("Erro", isPresented: Binding(
                                    get: { viewModel.errorMessage != nil },
                                    set: { newValue in
                                        if !newValue {
                                            viewModel.errorMessage = nil
                                        }
                                    }
                                )) {
                                    Button("OK", role: .cancel) {
                                        viewModel.errorMessage = nil
                                    }
                                } message: {
                                    Text(viewModel.errorMessage ?? "")
                                }
    }
    
}

#Preview {
    SwapView()
}
