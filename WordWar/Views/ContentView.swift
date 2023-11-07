//
//  ContentView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToDetail = false
    @State private var showGameView = false
    @StateObject var viewModel = ContentViewViewModel()
    var body: some View {
        VStack {
            NavigationStack{
                ZStack{
                    Color(red: 0.20, green: 0.60, blue: 0.86).edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("Welcome to Shiritori Game!")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
//                        Button("Play"){
//                            print("Play is clicked")
//                            showGameView = true
//                        }
//                        .foregroundColor(.red)
//                        .font(.system(size:25))
//                        .navigationDestination(isPresented: $showGameView) {
//                                               LoginView()
//                                           }
//
                        LoginView()
                        
                    }
                }
            }
        }
 
    }
}

#Preview {
    ContentView()
}
