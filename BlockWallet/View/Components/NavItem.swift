import SwiftUI

struct NavItem<Destination: View>: View {
    
    let icon: String
    let title: String
    let item: TabBarItem
    let destination: Destination
    let currentPage: TabBarItem
    
    init(
        icon: String,
        title: String,
        item: TabBarItem,
        currentPage: TabBarItem,
        @ViewBuilder destination: () -> Destination
    ) {
        self.icon = icon
        self.title = title
        self.item = item
        self.destination = destination()
        self.currentPage = currentPage
    }
    
    var isSelected: Bool {
        currentPage == item
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 4) {
                
                Image(systemName: icon)
                    .foregroundColor(isSelected ? .blue : .gray)
                
                Text(title)
                    .font(.caption2)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
    }
}
