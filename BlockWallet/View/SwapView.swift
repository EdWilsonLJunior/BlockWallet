import SwiftUI

struct SwapView: View {

    var initialCoinId: String? = nil
    @StateObject private var viewModel: SwapViewModel
    @State private var showCoinSelector = false

    init(initialCoinId: String? = nil) {
        self.initialCoinId = initialCoinId
        _viewModel = StateObject(wrappedValue: SwapViewModel(initialCoinId: initialCoinId))
    }

    var body: some View {
        VStack(spacing: 24) {

                // Handle
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)

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
                .onAppear {
                    UISegmentedControl.appearance().setTitleTextAttributes(
                        [.foregroundColor: UIColor.white],
                        for: .normal
                    )
                    UISegmentedControl.appearance().setTitleTextAttributes(
                        [.foregroundColor: UIColor.black],
                        for: .selected
                    )
                }
                
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
                                            coin: "BRL",
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
