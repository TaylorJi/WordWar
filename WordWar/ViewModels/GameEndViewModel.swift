//
//  GameEndViewModel.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-19.
//

import Foundation
import FirebaseFirestore

class GameEndViewModel : ObservableObject {
    @Published var topScores: [(email: String, score: Int)] = []

    private var db = Firestore.firestore()
    
    func updateScoreIfNeeded(forEmail email: String, with newScore: Int, completion: @escaping () -> Void) {
            db.collection("test")
                .whereField("email", isEqualTo: email)
                .getDocuments { [weak self] querySnapshot, err in
                    if let err = err {
                        print("Error getting documents: \(err)")
                        completion()
                        return
                    }

                    guard let document = querySnapshot?.documents.first else {
                        print("No user found with this email.")
                        completion()
                        return
                    }

                    let userId = document.documentID
                    if let currentScore = document.data()["score"] as? Int {
                        // Step 2: Compare Scores and Update if Necessary
                        if newScore > currentScore {
                            self?.updateScore(for: userId, with: newScore, completion: completion)
                        } else {
                            print("New score is not higher than the current score.")
                            completion()
                        }
                    }
                }
        }
    
        private func updateScore(for userId: String, with newScore: Int, completion: @escaping () -> Void) {
            let userDocument = db.collection("test").document(userId)

            userDocument.updateData(["score": newScore]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated with new score")
                    completion() // Call the completion handler after successful update
                }
            }
        }


    func fetchTopScores() {
        db.collection("test")
          .order(by: "score", descending: true)
          .limit(to: 5)
          .getDocuments { (querySnapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
              } else {
                  var scoresArray: [(email: String, score: Int)] = []
                  for document in querySnapshot!.documents {
                      if let score = document.data()["score"] as? Int,
                         let email = document.data()["email"] as? String {
                          scoresArray.append((email: email, score: score))
                      }
                  }
                  DispatchQueue.main.async {
                      self.topScores = scoresArray
                  }
              }
          }
    }

    
}
