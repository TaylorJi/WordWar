//
//  GameController.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-01.
//

import Foundation

import Foundation



class GameController {
    
    struct Word: Codable {
        let word: String
    }
    func firstRandomWord(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
        var request = URLRequest(url: url)
        request.setValue(Constant.API.randomWordAPI, forHTTPHeaderField: "X-Api-Key")

        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data, let word = String(data: data, encoding: .utf8) {
                completion(word)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    func isWordValid(word: String, completion: @escaping (Bool) -> Void) {
        guard !word.isEmpty else { return }

        let urlString = "\(Constant.API.wordCheckAPI)\(word)"

        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    print("Error fetching data")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    func extractWord(from jsonString: String) -> String? {
        do {
            if let jsonData = jsonString.data(using: .utf8) {
                let decodedWord = try JSONDecoder().decode(Word.self, from: jsonData)
                return decodedWord.word
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
        return nil
    }
    
    
    func shiritoriRuleChecker(wordToBeTested: String, acceptedWord: String) -> Bool {
        if let firstChar = wordToBeTested.first, let lastChar = acceptedWord.last {
            return String(firstChar).uppercased() == String(lastChar).uppercased()
        }
        return false
    }
    
    func isUsedWord(wordToBeTested: String) -> Bool{
        
        if UsedWords.typedWords.contains(wordToBeTested){
            return true
        }
        return false
        
    }
    
    func addToUsedWords(wordToAdd: String){
        UsedWords.typedWords.insert(wordToAdd)
    }
    
//    func shiritoriRuleChecker(wordToBeTested: String, acceptedWord: String) -> Bool {
//        if wordToBeTested.first.uppercased() == acceptedWord.last {
//            return true
//        }
//        return false
//    }
    
}