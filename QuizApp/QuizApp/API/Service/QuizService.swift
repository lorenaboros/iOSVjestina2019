//
//  QuizService.swift
//  QuizApp
//
//  Created by Lorena Boroš on 26/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class QuizService {
  
    func fetchQuizes(completion: @escaping ((QuizResponse?) -> Void)) {
        let url = "https://iosquiz.herokuapp.com/api/quizzes"
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let quizzes = try decoder.decode(QuizResponse.self, from: data)
                        completion(quizzes)
                    } catch {
                        print(error)
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        }
    }
    
    func sendResults(quiz_id: Int ,user_id: Int, time: Double, correctAnswers: Int, completion: @escaping ((Int?) -> Void)) {
        let url = "https://iosquiz.herokuapp.com/api/result"
        let parameters = ["quiz_id": quiz_id, "user_id": user_id, "time": time,"no_of_correct": correctAnswers] as [String : Any]
    
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
            
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let userDefaults = UserDefaults.standard
            guard let value = userDefaults.string(forKey: "authToken") else {
                return
            }
            request.addValue(value, forHTTPHeaderField: "Authorization")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse
                    else {
                        print("error: not a valid http response")
                        return
                }
                completion(httpResponse.statusCode)
            }
            dataTask.resume()
        }
    }
}
