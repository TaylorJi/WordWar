//
//  Constants.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import Foundation


struct Constant {
    struct API{
        static let randomWordAPI = "https://api.api-ninjas.com/v1/randomword"
        static let wordCheckAPI = "https://api.dictionaryapi.dev/api/v2/entries/en/"
        static let findWordWithStartLetter = "https://api.datamuse.com/words?sp="
    }
    struct messages{
        static let invalidMSG = "The word is not in dictionary"
        static let violdatedRule = "The first letter of your answer must start with the last letter of the given word or avoid using the same word"
    }
    struct score{
        static let gmaeScore = "Game Score: "
        
    }
    struct timer {
        static let timer = 60
    }
    
    
}
