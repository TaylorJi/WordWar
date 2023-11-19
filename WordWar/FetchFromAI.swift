//
//  FetchFromAI.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-17.
//

import Foundation

func fetchWordStartingWith(letter: String, completion: @escaping (String?) -> Void) {
    let url = URL(string: "https://api.datamuse.com/words?sp=\(letter)*")!
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error making API call: \(error)")
            completion(nil)
            return
        }
        
        if let data = data {
            do {
                let words = try JSONDecoder().decode([DatamuseWord].self, from: data)
                if let randomWord = words.randomElement()?.word {
                    completion(randomWord)
                } else {
                    completion(nil)
                }
            } catch {
                print("Error decoding response: \(error)")
                completion(nil)
            }
        } else {
            print("No data received")
            completion(nil)
        }
    }.resume()
}

struct DatamuseWord: Codable {
    let word: String
}
