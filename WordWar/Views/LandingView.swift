//
//  LandingView.swift
//  WordWar
//
//  Created by Siwoon Lim on 2023-11-26.
//

import SwiftUI

struct LandingView: View {
    @State private var selectedTab = 0
    @State private var isShowingGameView = false
    @State private var isShowingLoginView = false

    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }
    
    var body: some View {
        NavigationStack{
            
            let currentUserEmail = UserManager.shared.getCurrentUserEmail() ?? "Unknown"
//            let currentUserScore = UserManager.shared.getCurrentUserScore() ?? 0
            TabView(selection: $selectedTab) {
                ZStack {
                    // Use a gradient for the background
                    LinearGradient(gradient: Gradient(colors: [Color.primary, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("Welcome to WordWar, \(currentUserEmail)!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        NavigationLink(destination: InstructionView()) {
                            Text("How to Play")
                                .font(.headline)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.purple)
                                .cornerRadius(30)
                                .shadow(radius: 10)
                        }
                        .padding(.top, 50)
                        
                        NavigationLink(destination: GameView()) {
                            Text("Start Game")
                                .font(.headline)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.purple)
                                .cornerRadius(30)
                                .shadow(radius: 10)
                        }
                        .padding(.top, 50)
                        
                        NavigationLink(destination: MultipPlayerView()) {
                            Text("PVP")
                                .font(.headline)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.purple)
                                .cornerRadius(30)
                                .shadow(radius: 10)
                        }
                        .padding(.top, 50)
                    }
                }
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Game")
                    
                }
                .tag(0)
                RankingView(userEmail: currentUserEmail)
                
//                GameEndView(userScore: currentUserScore, userEmail: currentUserEmail)
                    .tabItem {
                        Image(systemName: "chart.bar.doc.horizontal")
                        Text("LeaderBoard")
                    }
                    .tag(1)
                
            }
            .navigationDestination(isPresented: $isShowingLoginView) {
                            ContentView()
                        }
            .accentColor(Color.white)
            .navigationBarBackButtonHidden(true)
                       .navigationBarItems(leading: Button(action: {
                           // Perform the action you want when "Logout" is tapped
                           isShowingLoginView = true
                           
                       }) {
                           Text("Logout")
                       })
       

        }
    }
}

#Preview {
    LandingView()
}
