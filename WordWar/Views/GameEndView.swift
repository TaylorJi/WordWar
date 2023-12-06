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
    @State private var isShowingLandingView = false
    @State private var topScores: [(email: String, score: Int)] = []
    @StateObject var gameEndViewModel = GameEndViewModel()
    
    var body: some View {

            NavigationStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.primary, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 20) {
                        Text("\(userEmail) score is \(userScore)")
                            .bold()
                            .foregroundColor(.white)
                            .font(.title3)
                        RankingListView(topScores: gameEndViewModel.topScores)
                        
                        HStack{
                            Button(action: {
                                isShowingLandingView = true
                            }) {
                                Text("Go Home")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.purple)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            }

                            Button(action: {
                                isShowingGameView = true
                            }) {
                                Text("Play again")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.purple)
                                    .cornerRadius(10)
                                    .shadow(radius: 10)
                            }
                         
                            
                        }
                
                       
                    }
                    .cornerRadius(30)
                    .padding(20)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("War is Over")
                            .foregroundColor(Color.red)
                            .font(.title)
                            .bold()
                    }
                }
                .navigationDestination(isPresented: $isShowingGameView) {
                    GameView()
                }
                
                .navigationDestination(isPresented: $isShowingLandingView) {
                    LandingView()
                }
                
                .onAppear {
                    gameEndViewModel.updateScoreIfNeeded(forEmail: userEmail, with: userScore) {
                        gameEndViewModel.fetchTopScores()
                    }
                }
                .navigationBarBackButtonHidden(true)

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



