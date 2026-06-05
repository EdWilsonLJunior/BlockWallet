import SwiftUI

struct BottomBarView: View {
    var body: some View {
        ZStack {
            
            HStack {
                NavItem(icon: "house", title: "Home") {
                    DashboardView()
                }
                
                Spacer()
                    .frame(width: 40)
                
                NavItem(icon: "chart.bar", title: "Market") {
                    DashboardView()
                }
                
                Spacer()
                    .frame(width: 80)
                
                NavItem(icon: "wallet.pass", title: "Assets") {
                    DashboardView()
                }
                
                Spacer()
                    .frame(width: 40)
                
                NavItem(icon: "line.3.horizontal", title: "Menu") {
                    MenuView()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            
            NavigationLink(destination: DashboardView()) {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.white)
                    )
            }
            .offset(y: -25)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    BottomBarView()
}
