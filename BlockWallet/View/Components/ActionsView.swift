import SwiftUI

struct ActionsView: View {
    var body: some View {
        HStack(spacing: 40) {
            ActionItem(icon: "arrow.up", title: "Enviar")
            ActionItem(icon: "arrow.down", title: "Receber")
            ActionItem(icon: "arrow.left.arrow.right", title: "Trocar")
        }
    }
}

struct ActionItem: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.08))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .foregroundColor(.blue)
            }
            
            Text(title)
                .foregroundColor(.white)
                .font(.footnote)
        }
    }
}

#Preview {
    ActionsView()
}
