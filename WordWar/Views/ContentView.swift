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
                    Color(red: 1.00, green: 0.20, blue: 0.06).edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("Welcome to Word War")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
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
