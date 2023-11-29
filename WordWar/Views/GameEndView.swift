//
//  GameEndView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-19.
//

import SwiftUI

struct GameEndView: View {
    let userScore: Int
    let userEmail: String // Assuming you have user's email
    @State private var isShowingGameView = false
    @State private var topScores: [(email: String, score: Int)] = []
    @StateObject var gameEndViewModel = GameEndViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                // Use a gradient for the background
                LinearGradient(gradient: Gradient(colors: [Color.primary, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
        
                VStack(spacing: 20) {
                    Text("\(userEmail) score is \(userScore)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title3)
                    List(gameEndViewModel.topScores.indices, id: \.self) { index in
                        HStack {
                            Group {
                                if index == 0 {
                                    Text("🥇")
                                } else if index == 1 {
                                    Text("🥈")
                                } else if index == 2 {
                                    Text("🥉")
                                } else {
                                    Text("\(index + 1).")
                                        .font(.system(size: 20))
                                }
                            }
                            .font(.system(size: 40))
                            
                            Text("\(gameEndViewModel.topScores[index].email):")
                                .foregroundColor(.black)
                                .font(.headline)
                            Spacer()
                            Text("\(gameEndViewModel.topScores[index].score)")
                                .foregroundColor(.black)
                                .font(.headline)
                        }
                        .padding(.vertical)
                    }
                    
//                    Button(action: {
//                        isShowingGameView = true
//                    }) {
//                        Text("Play again")
//                            .font(.headline)
//                            .padding()
//                            .background(Color.white)
//                            .foregroundColor(.purple)
//                            .cornerRadius(10)
//                            .shadow(radius: 10)
//                    }
                }
                .cornerRadius(30)
                .padding(20)
            }
            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("War is Over")
                                        .foregroundColor(Color.red) // Change the color here
                                        .font(.title)
                                        .bold()
                                }
                            }
            .navigationDestination(isPresented: $isShowingGameView) {
                GameView()
            }
            .onAppear {
                gameEndViewModel.updateScoreIfNeeded(forEmail: userEmail, with: userScore)
                gameEndViewModel.fetchTopScores()
            }
        }
    }
}

//Preview
struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample user email for the preview
        GameEndView(userScore: 20, userEmail: "example@example.com")
    }
}



