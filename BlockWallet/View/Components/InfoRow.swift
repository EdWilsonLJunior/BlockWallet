import SwiftUI

@ViewBuilder
func infoRow(title: String, value: String) -> some View {
    HStack {
        Text(title)
            .foregroundColor(.gray)
        
        Spacer()
        
        Text(value)
            .foregroundColor(.white)
    }
}
#Preview {
    infoRow(title: "Title", value: "Value")
}
