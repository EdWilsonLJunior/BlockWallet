import SwiftUI

struct CandleChartView: View {
    var body: some View {
        GeometryReader { geo in
            
            HStack(alignment: .center, spacing: 4) {
                
                ForEach(0..<20) { _ in
                    
                    let isGreen = Bool.random()
                    let height = CGFloat.random(in: 40...180)
                    
                    VStack {
                        Spacer()
                        
                        Rectangle()
                            .fill(isGreen ? Color.green : Color.red)
                            .frame(width: 6, height: height)
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    CandleChartView()
}
