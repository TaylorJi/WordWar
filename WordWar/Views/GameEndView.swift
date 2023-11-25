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

//                if !topScores.isEmpty {
//                    List(topScores, id: \.email) { score in
//                        Text("\(score.email): \(score.score)")
//                    }
//                } else {
//                    Text("Loading top scores...")
//                }

                Button("Play again") {
                    isShowingGameView = true
                }
            }
            .navigationTitle("Score Board")
            .navigationDestination(isPresented: $isShowingGameView) {
                GameView() // Replace with your actual GameView initialization if needed
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





//struct GameEndView: View {
//    let userScore: Int
//    let userEmail: String
//    @State private var isShowingGameView = false
//    @State private var topScores: [Int] = []
//    @StateObject var gameEndViewModel = GameEndViewModel()
//    var body: some View {
//        NavigationStack{
//            VStack{
//                Text("Your score is \(userScore)")
//                    .bold()
//                    .foregroundStyle(.red)
//                Text("End Game View")
//                Button("Play again") {
//                    isShowingGameView = true
//                    
//                }
//            }
//            .navigationTitle("Score Board")
//            .navigationDestination(isPresented: $isShowingGameView){
//                GameView()
//            }
//        }
//    }
//}
//
//#Preview {
//    // preview set the default game score: 20, test@test.ca
//    GameEndView(userScore: 20, userEmail: "test@test.ca")
//}
