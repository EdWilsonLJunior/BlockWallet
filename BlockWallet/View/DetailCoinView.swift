import SwiftUI

struct DetailCoin: View {
    
    var body: some View {
        VStack(spacing: 16) {
            
            // MARK: HEADER
            HStack {
                Text("BTC")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.horizontal)
            
            // MARK: CHART
            VStack(spacing: 8) {
                
                CandleChartView()
                    .frame(height: 200)
                
                // horários
                HStack {
                    Text("18:00")
                    Spacer()
                    Text("19:00")
                    Spacer()
                    Text("20:00")
                    Spacer()
                    Text("21:00")
                    Spacer()
                    Text("21:00")
                }
                .foregroundColor(.gray)
                .font(.caption2)
            }
            
            // MARK: TIME FILTERS
            HStack {
                timeButton("1m", selected: true)
                timeButton("5m")
                timeButton("15m")
                timeButton("1h")
                timeButton("1d")
                timeButton("Mais")
            }
            
            Divider().background(Color.gray.opacity(0.3))
            
            // MARK: BALANCE
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Available Balance")
                    .foregroundColor(.gray)
                    .font(.caption)
                
                Text("0.19873 BTC")
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: COIN ROW
            HStack {
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 40, height: 40)
                    .overlay(Text("₿").foregroundColor(.white))
                
                VStack(alignment: .leading) {
                    Text("BTC")
                        .foregroundColor(.white)
                        .bold()
                    
                    Text("Bitcoin")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("$3.00912")
                        .foregroundColor(.white)
                    
                    Text("(+0.68%)")
                        .foregroundColor(.green)
                        .font(.caption)
                }
            }
            
            Divider().background(Color.gray.opacity(0.3))
            
            // MARK: INFO
            VStack(spacing: 12) {
                infoRow(title: "Capitalização de Mercado", value: "$250M")
                infoRow(title: "Oferta Circulante", value:"$10M")
                infoRow(title: "Oferta Máxima", value:"5M")
                infoRow(title: "Oferta Total", value:"9M")
                infoRow(title: "Máxima Histórica", value:"$40")
                infoRow(title: "Mínima Histórica", value:"$4")
            }
                        
            Spacer()
            
            // MARK: BUTTON
            PrimaryButton(title: "Comprar") {
                print("Trade clicked")
            }
        }
        .padding()
        .background(AppGradient.primary.ignoresSafeArea().ignoresSafeArea())
    }
}

#Preview {
    DetailCoin()
}
