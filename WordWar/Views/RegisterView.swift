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
        NavigationView {
            NavigationStack {
                ZStack{
                    // Use a gradient for the background
                    LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)

                    Form {
                        if !viewModel.errMsg.isEmpty {
                            Text(viewModel.errMsg)
                                .foregroundColor(.red)
                        }

                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.top, 50)

                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.top, 10)
                        
                        Button("Register") {
                            print("Email: \(email)")
                            print("Password: \(password)")
                            viewModel.register()
                            if viewModel.validate() {
                                isShowingLoginView = true
                            }
                            print("user created")
                        }
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.top, 10)
                        .navigationDestination(isPresented: $isShowingLoginView) {
                            LoginView()
                        }
                    }
                    .navigationTitle("Sign Up")
                    .frame(maxHeight: .infinity)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
