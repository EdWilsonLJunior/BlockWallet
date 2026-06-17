import SwiftUI

struct MarketView: View {

    @StateObject private var viewModel = MarketViewModel.shared

    @State private var titleMovers: String = "Destaques"
    @State private var textButtonMovers: String = "Ver Todos"

    var body: some View {
        VStack(spacing: 20) {

            Text("Market")
                .foregroundColor(.white)
                .font(.headline)
                .padding(.top)

            ScrollView {
                VStack(spacing: 24) {
                    TopMoversView(
                        cryptoCard: viewModel.cryptoCard,
                        title: $titleMovers,
                        textButton: $textButtonMovers)
                }
                .padding(.horizontal)
            }
        }
        .background(AppGradient.primary.ignoresSafeArea().ignoresSafeArea())
        .onAppear {
            guard viewModel.cryptoCard.isEmpty else { return }
            Task { await viewModel.load() }
        }
    }
}

#Preview {
    MarketView()
}
