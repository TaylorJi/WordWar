//
//  InstructionView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-12-04.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.primary, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                Text("At the start, a random word will be given. The player must enter a word that starts with the last letter of the given word. If the word can be found in a dictionary and is valid, the user earns 10 points; if not, they lose 10 points. This is a time attack mode, so the goal is to achieve the highest score within the time limit. Players cannot repeat words. If a previously used word is entered, the player will lose 10 points. The total score and rankings will be displayed when the time is up. Good luck winning the Word War!")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    
                
            }
        }
    
    

        
    }
}

#Preview {
    InstructionView()
}
