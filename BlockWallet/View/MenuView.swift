import SwiftUI

struct MenuView: View {
    
    @State private var path: [MenuRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 24) {
                    
                    Text("Menu")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                    WalletHeaderView()
                    
                    VStack(spacing: 20) {
                        
                        MenuItem(icon: "creditcard", title: "Add payment method") {
                            path.append(.payment)
                        }
                        
                        MenuItem(icon: "list.bullet", title: "Activity log") {
                            path.append(.activity)
                        }
                        
                    }
                    
                    Divider()
                        .background(Color.gray.opacity(0.4))
                    
                    MenuItem(icon: "arrow.backward.circle", title: "Log Out", isDestructive: true) {
                        print("Logout tapped")
                    }
                    
                    Spacer()
                    
                    BottomBarView()
                }
                .padding()
            }
            
            .navigationDestination(for: MenuRoute.self) { route in
                switch route {
                case .payment:
                    DashboardView()
                case .activity:
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
