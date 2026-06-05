import SwiftUI

struct SuccessModalView: View {
    
    var title: String = "Sucesso"
    var message: String = "Operação realizada com sucesso!"
    var buttonTitle: String = "Finalizar"
    var onClose: () -> Void
    
    @State private var goToLogin: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    HStack {
                        Spacer()
                        
                        Button(action: onClose) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text(title)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    ZStack {
                        Circle()
                            .stroke(Color.blue, lineWidth: 2)
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                    .padding(.vertical, 10)
                    
                    Text(message)
                        .foregroundColor(.gray)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                    
                    Button() {
                        onClose()
                        goToLogin = true
                    } label: {
                        Text(buttonTitle)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                }
                .padding()
                .background(
                    LinearGradient(
                        colors: [Color(white: 0.1), Color.black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(20)
                .padding(.horizontal, 30)
            }
        }
        .navigationDestination(isPresented: $goToLogin) {
            LoginView()
        }
    }
}

#Preview {
    SuccessModalView(title: "Sucesso", message: "Ação Realizada com sucesso", buttonTitle: "Confirmar", onClose: {})
}
