//
//  GameViewModel.swift
//  WordWar
//
//  Created by Taylor Ji on 2023-11-18.
//

import Foundation

//class GameViewModel {
//    struct Word: Codable {
//        let word: String
//    }
//    func firstRandomWord(completion: @escaping (String?) -> Void) {
//        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
//           let xml = FileManager.default.contents(atPath: path),
//           let secrets = try? PropertyListDecoder().decode([String: String].self, from: xml) {
//            let apiKey = secrets["RANDOMWORDAPIKEY"]!
//            let url = URL(string: Constant.API.rnadomWordAPI)!
//            var request = URLRequest(url: url)
//            request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
//            
//            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//                if let data = data, let word = String(data: data, encoding: .utf8) {
//                    completion(word)
//                } else {
//                    completion(nil)
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func isWordValid(word: String, completion: @escaping (Bool) -> Void) {
//        guard !word.isEmpty else { return }
//
//        let urlString = "\(Constant.API.wordCheckAPI)\(word)"
//
//        
//        if let url = URL(string: urlString) {
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                guard error == nil else {
//                    print("Error fetching data")
//                    return
//                }
//                
//                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                    completion(true)
//                } else {
//                    completion(false)
//                }
//            }
//            task.resume()
//        }
//    }
//    
//    func extractWord(from jsonString: String) -> String? {
//        do {
//            if let jsonData = jsonString.data(using: .utf8) {
//                let decodedWord = try JSONDecoder().decode(Word.self, from: jsonData)
//                return decodedWord.word
//            }
//        } catch {
//            print("Error decoding JSON: \(error)")
//        }
//        return nil
//    }
//    
//    
//    func shiritoriRuleChecker(wordToBeTested: String, acceptedWord: String) -> Bool {
//        if let firstChar = wordToBeTested.first, let lastChar = acceptedWord.last {
//            return String(firstChar).uppercased() == String(lastChar).uppercased()
//        }
//        return false
//    }
//    
//    func isUsedWord(wordToBeTested: String) -> Bool{
//        
//        if UsedWords.typedWords.contains(wordToBeTested){
//            return true
//        }
//        return false
//        
//    }
//    
//    func addToUsedWords(wordToAdd: String){
//        UsedWords.typedWords.append(wordToAdd)
//    }
//    
//    func fetchWordStartingWith(letter: String, completion: @escaping (String?) -> Void) {
//        let url = URL(string: "\(Constant.API.findWordWithStartLetter)\(letter)*")!
//        var request = URLRequest(url: url)
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error making API call: \(error)")
//                completion(nil)
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let words = try JSONDecoder().decode([DatamuseWord].self, from: data)
//                    if let randomWord = words.randomElement()?.word {
//                        completion(randomWord)
//                    } else {
//                        completion(nil)
//                    }
//                } catch {
//                    print("Error decoding response: \(error)")
//                    completion(nil)
//                }
//            } else {
//                print("No data received")
//                completion(nil)
//            }
//        }.resume()
//    }
//    
//    func clearUserWords() {
//        UsedWords.typedWords.removeAll()
//    }
//
//    struct DatamuseWord: Codable {
//        let word: String
//    }
//
//    
//    
//    
//    
//}

class GameViewModel {
    struct Word: Codable {
        let word: String
    }

    func firstRandomWord(completion: @escaping (String?) -> Void) {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path),
           let secrets = try? PropertyListDecoder().decode([String: String].self, from: xml) {
            let apiKey = secrets["RANDOMWORDAPIKEY"]!
            let url = URL(string: Constant.API.randomWordAPI)!
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let word = String(data: data, encoding: .utf8) {
                    completion(word)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        }
    }

    func checkWordDifficulty(word: String, completion: @escaping (Double?) -> Void) {
        guard let url = URL(string: "https://twinword-language-scoring.p.rapidapi.com/word/?entry=\(word)") else {
            completion(nil)
            return
        }
        
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path),
           let secrets = try? PropertyListDecoder().decode([String: String].self, from: xml) {
            let RapidAPIKey = secrets["XRAPIDAPIKEY"]!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("twinword-language-scoring.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
            request.setValue(RapidAPIKey, forHTTPHeaderField: "x-rapidapi-key")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(TwinwordResponse.self, from: data)
                        completion(response.ten_degree)
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            task.resume()
            
        }

//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("twinword-language-scoring.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
//        request.setValue("your-rapidapi-key", forHTTPHeaderField: "x-rapidapi-key")
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let response = try JSONDecoder().decode(TwinwordResponse.self, from: data)
//                    completion(response.value)
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                    completion(nil)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//        task.resume()
    }

    struct TwinwordResponse: Codable {
        let entry: String
        let value: Double
        let ten_degree: Double
        let response: String
        let result_code: String
        let result_msg: String
    }

    func isWordValid(word: String, completion: @escaping (Bool) -> Void) {
        guard !word.isEmpty else { return }

        let urlString = "\(Constant.API.wordCheckAPI)\(word)"

        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
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

    func isUsedWord(wordToBeTested: String) -> Bool {
        return UsedWords.typedWords.contains(wordToBeTested)
    }

    func addToUsedWords(wordToAdd: String) {
        UsedWords.typedWords.append(wordToAdd)
    }

    func fetchWordStartingWith(letter: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "\(Constant.API.findWordWithStartLetter)\(letter)*")!
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

    func clearUserWords() {
        UsedWords.typedWords.removeAll()
    }

    struct DatamuseWord: Codable {
        let word: String
    }
}

