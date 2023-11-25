//
//  GameEndView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-19.
//

import SwiftUI

struct GameEndView: View {
    let userScore: Int
    let userEmail: String // Assuming you have the user's email

    @State private var isShowingGameView = false
    @State private var topScores: [(email: String, score: Int)] = []
    @StateObject var gameEndViewModel = GameEndViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Text("\(userEmail) score is \(userScore)")
                    .bold()
                    .foregroundStyle(.red)
                Text("Rankings")
                List(gameEndViewModel.topScores, id: \.email) { score in
                             Text("\(score.email): \(score.score)")
                         }

                Button("Play again") {
                    isShowingGameView = true
                }
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 30) // Fill the entire space
                .background(Color.red)
                .cornerRadius(10) // Adjust corner radius to your preference
            }
            .navigationTitle("War is over")
 
            .navigationDestination(isPresented: $isShowingGameView) {
                GameView() 
            }
            .onAppear {
                updateAndFetchScores()
            }
        }
    }

    private func updateAndFetchScores() {
        // Update the user's score
        gameEndViewModel.updateScoreIfNeeded(forEmail: userEmail, with: userScore)

        // Fetch the top scores
        gameEndViewModel.fetchTopScores()
    }
}

//Preview
struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample user email for the preview
        GameEndView(userScore: 20, userEmail: "example@example.com")
    }
}




