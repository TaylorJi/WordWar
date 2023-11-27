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
        NavigationStack {
            ZStack {
                // Use a gradient for the background
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    LoginView()
                        .cornerRadius(30)
                        .shadow(radius: 10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
