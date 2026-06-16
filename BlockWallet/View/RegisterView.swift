//
//  RegisterView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 03/06/26.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject private var viewModel = RegisterViewModel()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var goToLogin: Bool = false
    @State private var userName: String = ""
    @State private var textUserName: String = "Nome de usuário"
    @State private var textUserNamePlaceholder: String = "Nome de usuário"
    @State private var showSucessModal: Bool = false
    @State private var isEmailInvalid: Bool = false
    
    @State var titleAlert: String = "Sucesso"
    @State var messageAlert: String = "Operação realizada com sucesso!"
    @State var alertType: AlertType = .error
    @State var toLogin: Bool = false
    @State var isLoading: Bool = false
    
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView{
                    VStack (spacing: 20)
                    {
                        Image("logo")		
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 250, maxHeight: 200)
                    }
                    VStack(alignment: .leading, spacing: 20) {
   
                        
                        VStack(alignment: .leading) {
                            Text("Crie sua conta agora")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                            
                            Text("Informe seus dados e clique em registrar para continuar")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        InputTextField(text: $textUserName, placeholder: $textUserNamePlaceholder, value: $userName)
                        
                        EmailField(email: $email, isInvalid: $isEmailInvalid)
                        
                        PasswordField(
                            title: "Senha",
                            placeholder: "Insira sua senha",
                            text: $password
                        )
                        
                        Spacer()
                        PrimaryButton(title: "Registrar", isDisable: (userName.isEmpty || email.isEmpty || password.isEmpty) || isEmailInvalid) {
                            isLoading = true
                            
                            Task {
                                let isSuccess = await viewModel.register(userName: userName, email: email, password: password)
                                print(isSuccess)
                                
                                if(isSuccess) {
                                    email = ""
                                    password = ""
                                    userName = ""
                                    
                                    alertType = .success
                                    showSucessModal = true
                                } else {
                                    alertType = .error
                                    titleAlert = "Ops!"
                                    messageAlert = "Não foi possível realizar o seu cadastro, tente novamente mais tarde"
                                    
                                    showSucessModal = true
                                }
                                isLoading = false
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                .padding()
                .background(AppGradient.primary.ignoresSafeArea().ignoresSafeArea())
            }
            .navigationDestination(isPresented: $toLogin) {
                LoginView()
            }
            
            if isLoading {
                Color.black.opacity(0.4).ignoresSafeArea()
                
                ProgressView("Aguarde...")
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .foregroundStyle(.black)
                    .cornerRadius(12)
            }
            
            if showSucessModal {
                SuccessModalView(title: titleAlert, message: messageAlert, alertType: alertType) {
                    showSucessModal = false
                    if alertType == .success {
                        toLogin = true
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
