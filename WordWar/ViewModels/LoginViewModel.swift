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
        
    func login(completion: @escaping (Bool) -> Void) {
            guard validate() else {
                completion(false)
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.errMsg = error.localizedDescription
                        completion(false)
                       
                    } else if let user = result?.user {
                        UserManager.shared.setCurrentUserEmail(user.email ?? "")
                        completion(true)
                    } else {
                        self?.errMsg = "An unknown error occurred."
                        completion(false)
                    }
                }
            }
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
