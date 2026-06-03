//
//  RegisterView.swift
//  BlockWallet
//
//  Created by Junior, Ed Wilson Luciano on 03/06/26.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var goToLogin: Bool = false
    @State private var userName: String = ""
    @State private var textUserName: String = "Nome de usuário"
    @State private var textUserNamePlaceholder: String = "Nome de usuário"
    @State private var showSucessModal: Bool = false
    
    var body: some View {
        ZStack {
            
            
            NavigationStack {
                ScrollView{
                    VStack(alignment: .leading, spacing: 20) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 250)
                            .frame(maxWidth: .infinity)
                        
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
                        
                        EmailField(email: $email)
                        
                        PasswordField(
                            title: "Senha",
                            placeholder: "Insira sua senha",
                            text: $password
                        )
                        
                        Spacer()
                        
                        PrimaryButton(title: "Registrar") {
                            showSucessModal = true
                            goToLogin = true
                        }
                        
                    }
                    .navigationDestination(isPresented: $goToLogin) {
                        LoginView()
                    }
                    
                    if showSucessModal {
                        SuccessModalView {
                            showSucessModal = false
                        }
                    }
                }
                .padding()
                .background(Color.black.ignoresSafeArea())
            }
            .navigationBarBackButtonHidden(true)
            
            if showSucessModal {
                SuccessModalView {
                    showSucessModal = false
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
