import SwiftUI

struct MenuView: View {
        
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Text("Menu")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                WalletHeaderView()
                
                VStack(spacing: 20) {
                    NavigationLink(destination: DashboardView()) {
                        MenuItem(icon: "creditcard", title: "Add payment method")
                    }
                    
                    NavigationLink(destination: DashboardView()) { // Alterado para Dashboard ou uma View de Activity futura
                        MenuItem(icon: "list.bullet", title: "Activity")
                    }
                }
                
                Divider()
                    .background(Color.gray.opacity(0.4))
                    NavigationLink(destination: LoginView()) {
                        MenuItem(icon: "arrow.backward.circle", title: "Log Out", isDestructive: true)
                }
                                    
                Spacer()
                
                BottomBarView()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MenuView()
}
