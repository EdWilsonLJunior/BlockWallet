import SwiftUI

@ViewBuilder
func timeButton(_ text: String, selected: Bool = false) -> some View {
    Text(text)
        .foregroundColor(selected ? .white : .gray)
        .font(.caption)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(selected ? Color.gray.opacity(0.3) : Color.clear)
        .cornerRadius(6)
}
