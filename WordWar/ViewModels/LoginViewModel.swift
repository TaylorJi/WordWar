//
//  LoginViewModel.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import Foundation
import FirebaseAuth


class LoginViewViewModel : ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errMsg: String = ""

    init(){}
    
    func login() {
        guard validate() else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) // sign in
        
    }
    
    private func validate() -> Bool {
      errMsg = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
           errMsg = "Please fill email and password fields."
           return false
        }
      
      
      // email@foo.com
      guard email.contains("@") && email.contains(".") else {
         errMsg = "Please enter a valid email address."
         return false
      }
      
      return true
    }
}
