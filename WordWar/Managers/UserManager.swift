//
//  UserManager.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-24.
//

import Foundation

class UserManager {
    static let shared = UserManager()

    var currentUserEmail: String?
    var currentUserScore: Int?

    private init() {}

    func setCurrentUserEmail(_ email: String) {
        currentUserEmail = email
    }

    func getCurrentUserEmail() -> String? {
        return currentUserEmail
    }

    func setCurrentUserScore(_ score: Int) {
        currentUserScore = score
    }

    func getCurrentUserScore() -> Int? {
        return currentUserScore
    }
}
