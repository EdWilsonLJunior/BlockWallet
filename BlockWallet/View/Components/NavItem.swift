import SwiftUI

struct NavItem: View {

    let icon: String
    let title: String
    let item: TabBarItem
    let currentPage: TabBarItem
    let onTap: () -> Void

    var isSelected: Bool {
        currentPage == item
    }

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(title)
                    .font(.caption2)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
        .buttonStyle(.plain)
    }
}
