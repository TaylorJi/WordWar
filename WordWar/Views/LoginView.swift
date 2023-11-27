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
    @State private var isShowingLandingView = false
    @State private var isShowingRegisterView = false
    @StateObject var loginViewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    Form {
                        if !loginViewModel.errMsg.isEmpty {
                            Text(loginViewModel.errMsg)
                                .foregroundColor(.red)
                        }
                        TextField("Email", text: $loginViewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.top, 50)

                        SecureField("Password", text: $loginViewModel.password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.top, 10)
                        
                        Button("Log In") {
                            // firebase will handle authentication
                            loginViewModel.login { success in
                                if success {
                                    isShowingLandingView = true
                                    loginViewModel.email = ""
                                    loginViewModel.password = ""
                                } // No need to handle failure here as errMsg will be updated
                            }
                        }
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.top, 10)
                        
                        Button("Sign Up") {
                            // navigate to register view
                            isShowingRegisterView = true
                        }
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.top, 10)

                        .navigationDestination(isPresented: $isShowingLandingView) {
                            LandingView()
                        }
                        .navigationDestination(isPresented: $isShowingRegisterView) {
                            RegisterView()
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
