import SwiftUI

struct PriceLineChartView: View {
    var points: [ChartDataPoint]

    private var minPrice: Double { points.map(\.price).min() ?? 0 }
    private var maxPrice: Double { points.map(\.price).max() ?? 1 }
    private var isUp: Bool {
        guard let first = points.first?.price,
              let last  = points.last?.price else { return true }
        return last >= first
    }

    private let yLabelsCount = 4  // quantidade de labels no eixo Y

    var body: some View {
        HStack(spacing: 4) {

            // MARK: Eixo Y (labels de preço)
            VStack(alignment: .trailing, spacing: 0) {
                ForEach(yLabels.indices, id: \.self) { i in
                    Text(formatPrice(yLabels[i]))
                        .font(.system(size: 9))
                        .foregroundColor(.gray)
                    if i < yLabels.count - 1 {
                        Spacer()
                    }
                }
            }
            .frame(width: 60)

            // MARK: Gráfico
            GeometryReader { geo in
                ZStack {
                    // Grid lines + Canvas
                    Canvas { context, size in
                        let range = maxPrice - minPrice
                        guard range > 0, points.count >= 2 else { return }

                        let lineColor = isUp ? Color.green : Color.red
                        let count     = CGFloat(points.count - 1)

                        func xFor(_ index: Int) -> CGFloat {
                            size.width * CGFloat(index) / count
                        }

                        func yFor(_ price: Double) -> CGFloat {
                            size.height - CGFloat((price - minPrice) / range) * size.height
                        }

                        // MARK: Linhas de grid horizontais
                        for label in yLabels {
                            let y = yFor(label)
                            var grid = Path()
                            grid.move(to: CGPoint(x: 0, y: y))
                            grid.addLine(to: CGPoint(x: size.width, y: y))
                            context.stroke(
                                grid,
                                with: .color(Color.white.opacity(0.07)),
                                lineWidth: 1
                            )
                        }

                        // MARK: Área preenchida
                        var area = Path()
                        area.move(to: CGPoint(x: xFor(0), y: size.height))
                        for (i, point) in points.enumerated() {
                            area.addLine(to: CGPoint(x: xFor(i), y: yFor(point.price)))
                        }
                        area.addLine(to: CGPoint(x: size.width, y: size.height))
                        area.closeSubpath()
                        context.fill(area, with: .color(lineColor.opacity(0.15)))

                        // MARK: Linha de preço
                        var line = Path()
                        for (i, point) in points.enumerated() {
                            let pt = CGPoint(x: xFor(i), y: yFor(point.price))
                            if i == 0 { line.move(to: pt) } else { line.addLine(to: pt) }
                        }
                        context.stroke(line, with: .color(lineColor), lineWidth: 2)

                        // MARK: Ponto final
                        if let last = points.last {
                            let cx  = xFor(points.count - 1)
                            let cy  = yFor(last.price)
                            let dot = Path(ellipseIn: CGRect(x: cx - 4, y: cy - 4, width: 8, height: 8))
                            context.fill(dot, with: .color(lineColor))
                        }
                    }

                    // MARK: Label do preço atual (último ponto)
                    if let last = points.last, (maxPrice - minPrice) > 0 {  // ✅
                        let range   = maxPrice - minPrice
                        let yRatio  = CGFloat((last.price - minPrice) / range)
                        let yOffset = geo.size.height * (1 - yRatio)

                        Text(formatPrice(last.price))
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(isUp ? .green : .red)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(isUp ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                            )
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(y: yOffset - geo.size.height / 2)
                    }
                }
            }
        }
    }

    // MARK: - Helpers

    /// Gera os valores das linhas de grid no eixo Y (do maior para o menor)
    private var yLabels: [Double] {
        let step = (maxPrice - minPrice) / Double(yLabelsCount - 1)
        return (0..<yLabelsCount)
            .map { maxPrice - Double($0) * step }
    }

    private func formatPrice(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle           = .currency
        formatter.currencyCode          = "BRL"
        formatter.locale                = Locale(identifier: "pt_BR")
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: value)) ?? "R$ \(value)"
    }

}

#Preview {
    PriceLineChartView(points: ChartDataPoint.mock())
        .frame(height: 200)
        .padding()
        .background(Color.black)
}

