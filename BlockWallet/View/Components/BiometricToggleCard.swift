import SwiftUI

struct BiometricToggleCard: View {
    @Binding var isEnabled: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Habilitar biometria")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text("Habilite a biometria para agilizar os próximos logins")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            Spacer()
            
            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(Color.blue)
        }
        .padding()
        .background(Color(white: 0.15))
        .cornerRadius(16)
    }
}
