//
//  RegisterViewModel.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class RegisterViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errMsg = ""
    
    init() {
        
    }
    
    func register() {
        guard validate() else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
           guard let userId = result?.user.uid else {
              return
           }
           self?.insertUserRecord(id: userId)
        }

        
    }
    
    private func insertUserRecord(id: String) {
        let newUser = User(id: id, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        db.collection("users")
           .document(id)
           .setData(newUser.asDictionary())

        
    }
    
    public func validate() -> Bool {
        errMsg = ""
          
          guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty
          else {
             errMsg = "Please fill in name, email and password fields."
             return false
          }
          
          // email@foo.com
          guard email.contains("@") && email.contains(".") else {
             errMsg = "Please enter a valid email address."
             return false
          }
          
          guard password.count >= 6 else {
             errMsg = "Password must be at least 6 characters long."
             return false
          }
          
          return true

    }
}
