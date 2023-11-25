//
//  GameView.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import SwiftUI
import Combine  


struct GameView: View {
    @State private var acceptedWord = ""
    @State private var userInput = ""
    @State private var isRepeated : Bool? = nil
    @State private var isValidWord: Bool? = nil
    @State private var isValidRule: Bool? = nil
    @State private var message = ""
    @State private var score = 0
    @State private var timer: Timer.TimerPublisher?
    @State private var isShowingGameEndView = false

    @State private var timeRemaining = Constant.timer.timer
    @State private var cancellables = Set<AnyCancellable>()


    // socket for multi-player
//    @ObservedObject var socketManager = SocketIOManager()
    
    
    private var controller = GameController()
//    private let gameViewModel = GameViewModel()
    var body: some View {
        let currentUserEmail = UserManager.shared.getCurrentUserEmail() ?? "Unknown"

        NavigationStack{
            ZStack{
                Color.green.ignoresSafeArea(.all)
                VStack{
                    Text("Time Remaining: \(timeRemaining)")
                        .font(.title)
                    
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
//                    Text(socketManager.receivedMessage)
                    
                    
                    List(Array(UsedWords.typedWords.enumerated()), id: \.element) { index, word in
                        Text("\(index + 1). \(word)")
                        
                    }
                    TextField("Enter a word", text: $userInput)
                        .padding()
                        .border(Color.white, width: 2)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    
                    
                    Button("Enter") {
//                        socketManager.sendMessage(message: userInput)
                        isRepeated = controller.isUsedWord(wordToBeTested: userInput)
                        isValidRule = controller.shiritoriRuleChecker(wordToBeTested: userInput, acceptedWord: acceptedWord)
                        if isValidRule == true && isRepeated == false{
                            controller.isWordValid(word: userInput) { isValid in
                                DispatchQueue.main.async {
                                    self.isValidWord = isValid
                                    if isValid {
                                        
                                        self.acceptedWord = userInput
                                        controller.addToUsedWords(wordToAdd: self.acceptedWord)
                                        let lastLetter = String (self.acceptedWord.last ?? "a")
                                        
                                        controller.fetchWordStartingWith(letter: lastLetter) { word in
                                            DispatchQueue.main.async {
                                                if let newWord = word {
                                                    self.acceptedWord = newWord
                                                    controller.addToUsedWords(wordToAdd: self.acceptedWord)
                                                    message = ""
                                                } else {
                                                    print("error on AI")
                                                }
                                            }
                                        }
                                        userInput = ""
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
                                userInput = ""
                                print("The word must start with the last letter of the accepted word")
                                
                            }
                        }
                        
                        
                    }.foregroundColor(.red)
                        .navigationDestination(isPresented: $isShowingGameEndView) {
                                               GameEndView(userScore: score, userEmail: currentUserEmail)
                                           }

                    
                }
                .onAppear{
                    loadFirstRandomWord()
                    startTimer()
                    controller.clearUserWords()
                    
                }
                .onReceive(timer ?? Timer.publish(every: 1, on: .main, in: .common)) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        print("Time's up")
                        stopTimer()
                        
                    }
                }
                
                
                
            }
        }
    }
    
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
        timer?.connect().store(in: &cancellables)
        
        // Reset timer
        timeRemaining = timeRemaining
    }
    
    
    func stopTimer() {
        timer?.connect().cancel()
        isShowingGameEndView = true
    }
    
    
    func loadFirstRandomWord() {
        controller.firstRandomWord { word in
            if let word = word {
                if let extractedWord = controller.extractWord(from: word){
                    self.acceptedWord = extractedWord
                } else {
                    self.acceptedWord = "Error"
                }
            } else {
                print("Error fetching random word.")
            }
        }
    }
    
    // this function is for multi-player game
//    func initiateRealtimeWord(){
//        socketManager.word
//    }
    
}

#Preview {
    GameView()
}
