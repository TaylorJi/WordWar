//
//  GameView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import SwiftUI

struct GameView: View {
    @State private var acceptedWord = ""
    @State private var userInput = ""
    @State private var isRepeated : Bool? = nil
    @State private var isValidWord: Bool? = nil
    @State private var isValidRule: Bool? = nil
    @State private var message = ""
    @State private var score = 0
    @ObservedObject var socketManager = SocketIOManager()
    
    
    private var controller = GameController()
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea(.all)
            VStack{
                /*
                 For score
                 */
                HStack{
                    Text(Constant.score.gmaeScore)
                        .foregroundColor(.yellow)
                        .font(.system(size: 25))
                    Text(String(score))
                        .foregroundColor(.yellow)
                        .font(.system(size: 25))
                }
                Text(acceptedWord)
                    .foregroundColor(.white)
                    .font(.system(size: 35))
                Text(message).foregroundColor(.red)
                
                Spacer()
                Text(socketManager.receivedMessage)
                TextField("Enter a word", text: $userInput)
                    .padding()
                    .border(Color.white, width: 2)
                Button("Enter") {
                    socketManager.sendMessage(message: userInput)
                    isRepeated = controller.isUsedWord(wordToBeTested: userInput)
                    isValidRule = controller.shiritoriRuleChecker(wordToBeTested: userInput, acceptedWord: acceptedWord)
                    if isValidRule == true && isRepeated == false{
                        controller.isWordValid(word: userInput) { isValid in
                            DispatchQueue.main.async {
                                self.isValidWord = isValid
                                if isValid {
                                    self.acceptedWord = userInput
                                    controller.addToUsedWords(wordToAdd: self.acceptedWord)
                                    score += 10
                                    message = ""
                                } else {
                                    message = Constant.messages.invalidMSG
                                    score -= 10
                                    print("The user input word is invalid")
                                    // Handle invalid word case here, if needed.
                                }
                            }
                        }
                    } else {
                        // Handle invalid rule case here, if needed.
                        DispatchQueue.main.async {
                            self.isValidWord = false
                            message = Constant.messages.violdatedRule
                            score -= 10
                            print("The word must start with the last letter of the accepted word")
                            
                        }
                    }
                    
                    
                }.foregroundColor(.red)
                
            }
            .onAppear(perform: loadFirstRandomWord)
            
        }
    }
    
    
    func loadFirstRandomWord() {
        controller.firstRandomWord { word in
            if let word = word {
                if let extractedWord = controller.extractWord(from: word){
                    self.acceptedWord = extractedWord
                } else {
                    self.acceptedWord = "Error"
                }
                print("Randomly chosen word: \(word)")
            } else {
                print("Error fetching random word.")
            }
        }
    }
    
    func initiateRealtimeWord(){
        socketManager.word
    }
    
}

#Preview {
    GameView()
}
