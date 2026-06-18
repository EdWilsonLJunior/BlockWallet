import SwiftUI

struct DetailCoin: View {
    let coinId: String
    
    @StateObject private var viewModel: DetailCoinViewModel = DetailCoinViewModel()
    @State private var showBuySheet = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: HEADER
                    HStack {
                        Text(viewModel.detailCoinViewModel?.symbol ?? "--")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    
                    // MARK: CHART
                    VStack(spacing: 8) {
                        
//                        CandleChartView()
//                            .frame(height: 200)
                        
                        PriceLineChartView(points: viewModel.chartPoints)
                            .frame(height: 200)
                        
                        // horários
//                        HStack {
//                            Text("18:00")
//                            Spacer()
//                            Text("19:00")
//                            Spacer()
//                            Text("20:00")
//                            Spacer()
//                            Text("21:00")
//                            Spacer()
//                            Text("21:00")
//                        }
//                        .foregroundColor(.gray)
//                        .font(.caption2)
                    }
                    
                    // MARK: TIME FILTERS
//                    HStack {
//                        timeButton("1m", selected: true)
//                        timeButton("5m")
//                        timeButton("15m")
//                        timeButton("1h")
//                        timeButton("1d")
//                        timeButton("Mais")
//                    }
                    
                    Divider().background(Color.gray.opacity(0.3))
                    
                    // MARK: BALANCE
//                    VStack(alignment: .leading, spacing: 8) {
//                        
//                        Text("Available Balance")
//                            .foregroundColor(.gray)
//                            .font(.caption)
//                        
//                        Text("0.19873 BTC")
//                            .foregroundColor(.white)
//                            .font(.title2)
//                            .bold()
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // MARK: COIN ROW
                    HStack {
                        
                        AsyncImage(url: viewModel.detailCoinViewModel?.imageURL) { image in
                            image.resizable().scaledToFit()
                        } placeholder : {
                            Circle()
                                .fill(Color.orange)
                                
                                .overlay(Text("₿").foregroundColor(.white))
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(viewModel.detailCoinViewModel?.symbol ?? "--")
                                .foregroundColor(.white)
                                .bold()
                            
                            Text(viewModel.detailCoinViewModel?.name ?? "--")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 2) {
                            Text(viewModel.detailCoinViewModel?.currentPrice ?? "--")
                                .foregroundColor(.white)
                            
                            Text(viewModel.detailCoinViewModel?.priceChange24h ?? "--")
                                .foregroundColor(
                                    viewModel.detailCoinViewModel?.isPriceUp == true ? .green : .red
                                )
                                .font(.caption)
                        }
                    }
                    
                    Divider().background(Color.gray.opacity(0.3))
                    
                    // MARK: INFO
                    VStack(spacing: 12) {
                        infoRow(
                            title: "Capitalização de Mercado",
                            value: viewModel.detailCoinViewModel?.marketCap ?? "--"
                        )
                        infoRow(
                            title: "Oferta Circulante",
                            value: viewModel.detailCoinViewModel?.circulatingSupply ?? "--"
                        )
                        infoRow(
                            title: "Oferta Máxima",
                            value: viewModel.detailCoinViewModel?.maxSupply ?? "--"
                        )
                        infoRow(
                            title: "Oferta Total",
                            value: viewModel.detailCoinViewModel?.totalSupply ?? "--"
                        )
                        infoRow(
                            title: "Máxima Histórica",
                            value: viewModel.detailCoinViewModel?.ath ?? "--"
                        )
                        infoRow(
                            title: "Mínima Histórica",
                            value: viewModel.detailCoinViewModel?.atl ?? "--"
                        )
                    }
                                
                    Spacer()
                    
                    // MARK: BUTTON
                    PrimaryButton(title: "Comprar") {
                        showBuySheet = true
                    }
                }
                .padding()
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                ProgressView()
                    .tint(.white)
                    .scaleEffect(1.5)
            }
            
            if !viewModel.errorMessage.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.red)

                    Text("Algo deu errado")
                        .foregroundColor(.white)
                        .font(.headline)

                    Text(viewModel.errorMessage)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .multilineTextAlignment(.center)

                    Button("Tentar novamente") {
                        Task {
                            await viewModel.loadCoinDetail(id: coinId)
                        }
                    }
                    .foregroundColor(.blue)
                    .font(.subheadline)
                }
                .padding(24)
                .background(Color(white: 0.1))
                .cornerRadius(16)
                .padding()
            }
        }
        .background(AppGradient.primary.ignoresSafeArea().ignoresSafeArea())
        .sheet(isPresented: $showBuySheet) {
            SwapView(initialCoinId: coinId)
        }
        .task {
            await viewModel.loadCoinDetail(id: coinId)
        }
    }
}

#Preview {
    DetailCoin(coinId: "bitcoin")
}
