//
//  LoginView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowingGameView = false
    @State private var isShowingRegisterView = false
    @StateObject var loginViewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    if !loginViewModel.errMsg.isEmpty {
                        Text(loginViewModel.errMsg)
                            .foregroundColor(.red)
                    }
                    TextField("Email", text: $loginViewModel.email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $loginViewModel.password)
                      
                    Button("Log In") {
                        // firebase will handle authentication
                        loginViewModel.login { success in
                                  if success {
                                      isShowingGameView = true
                                      loginViewModel.email = ""
                                      loginViewModel.password = ""
                                  } // No need to handle failure here as errMsg will be updated
                              }
                    
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5.0)
                    
                    Button("Sign Up") {
                        // navigate to register view
                        isShowingRegisterView = true
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(5.0)
                    

                    .navigationDestination(isPresented: $isShowingGameView) {
                                           GameView()
                                       }
                    .navigationDestination(isPresented: $isShowingRegisterView) {
                                           RegisterView()
                                       }
                }
                .frame(maxHeight: .infinity)
                
           
                
             
                
                Spacer()
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView()
}
