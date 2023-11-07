//
//  RegisterView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isShowingLoginView = false
    @StateObject var viewModel = RegisterViewViewModel()
    var body: some View {
        
            NavigationStack {
                VStack {
                    if !viewModel.errMsg.isEmpty {
                        Text(viewModel.errMsg)
                            .foregroundColor(.red)
                    }
                    Form {
                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)

                        SecureField("Password", text: $viewModel.password)
                          
                        Button("Register") {
                            print("Email: \(email)")
                            print("Password: \(password)")
                            viewModel.register()
                            if viewModel.validate() {
                                isShowingLoginView = true
                            }
                            print("user created")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(5.0)
                        .navigationDestination(isPresented: $isShowingLoginView) {
                                               LoginView()
                                           }
                        
        
                    }
                    .frame(maxHeight: .infinity)
                }
                .navigationTitle("Sign Up")
                Spacer()
            }
        }
}

#Preview {
    RegisterView()
}
