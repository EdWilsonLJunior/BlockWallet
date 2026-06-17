import SwiftUI

struct MainView: View {
    
    @State private var currentTab: TabBarItem = .home
    @State private var goingForward: Bool = true
    @State private var showMenu: Bool = false
    
    func switchTo(_ tab: TabBarItem) {
        if tab == .menu {
            withAnimation(.easeInOut(duration: 0.3)) {
                showMenu = true
            }
            return
        }
        guard tab != currentTab else { return }
        goingForward = tab.order > currentTab.order
        withAnimation(.easeInOut(duration: 0.25)) {
            currentTab = tab
        }
    }
    
    @ViewBuilder
    private var tabContent: some View {
        switch currentTab {
        case .home:
            DashboardView()
        case .market:
            MarketView()
        case .assets:
            AssetsView(coins: mockCoins)
        default:
            DashboardView()
        }
    }
    
    var body: some View {
        GeometryReader { geo in
        ZStack(alignment: .trailing) {
            tabContent
                .transition(.asymmetric(
                    insertion: .move(edge: goingForward ? .trailing : .leading),
                    removal: .move(edge: goingForward ? .leading : .trailing)
                ))
                .id(currentTab)
                .safeAreaInset(edge: .bottom) {
                    BottomBarView(currentTab: $currentTab, switchTab: switchTo)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
            
            if showMenu {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showMenu = false
                        }
                    }
                    .transition(.opacity)
                
                MenuView(onClose: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showMenu = false
                    }
                }, switchTab: { tab in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showMenu = false
                    }
                    switchTo(tab)
                })
                .frame(width: geo.size.width * 0.78)
                .transition(.move(edge: .trailing))
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await MarketViewModel.shared.load()
        }
        } // GeometryReader
    }
    
}

#Preview {
    NavigationStack {
        MainView()
            .environment(SessionManager())
    }
}
