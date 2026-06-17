import SwiftUI

enum AlertType {
    case success
    case error
}

struct SuccessModalView: View {
    
    var title: String = ""
    var message: String = ""
    var buttonTitle: String = ""
    var onClose: () -> Void
    
    @State private var goToLogin: Bool = false
    var alertType: AlertType
    
    init(title: String = "Sucesso", message: String = "Operação realizada com sucesso!", buttonTitle: String = "Finalizar", alertType: AlertType = .success, onClose: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.onClose = onClose
        
        self.alertType = alertType
    }
    
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
                            .stroke(alertType == .error ? Color.red: Color.blue , lineWidth: 2)
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: alertType == .success ? "checkmark" : "xmark")
                            .foregroundColor( alertType == .error ? .red : .blue)
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
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                }
                .padding()
                .background(
                    AppGradient.primary.ignoresSafeArea()
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
