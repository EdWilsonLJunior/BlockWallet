import SwiftUI

struct NavItem<Destination: View>: View {
    
    let icon: String
    let title: String
    let destination: Destination
    
    init(icon: String,
         title: String,
         @ViewBuilder destination: () -> Destination) {
        self.icon = icon
        self.title = title
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                
                Text(title)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
    }
}
