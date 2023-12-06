//
//  RankingView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-12-04.
//

import SwiftUI

struct RankingView: View {
    let userEmail: String // Assuming you have user's email
    @State private var isShowingLandingView = false
    @State private var topScores: [(email: String, score: Int)] = []
    @StateObject var gameEndViewModel = GameEndViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Use a gradient for the background
                LinearGradient(gradient: Gradient(colors: [Color.primary, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
        
                VStack(spacing: 20) {
                    Text("Cuurent Player: ")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title3)
                    Text("\(userEmail)")
                        .bold()
                        .foregroundColor(.white)
                        .font(.title3)
                    RankingListView(topScores: gameEndViewModel.topScores)
                }
                .cornerRadius(30)
                .padding(20)
            }
            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("Ranking")
                                        .foregroundColor(Color.red)
                                        .font(.title)
                                        .bold()
                                }
                            }
            .navigationDestination(isPresented: $isShowingLandingView) {
                LandingView()
            }
            .onAppear {
                gameEndViewModel.fetchTopScores()
            }
        }
    }
}

#Preview {
    RankingView(userEmail: "example@example.ca")
}
