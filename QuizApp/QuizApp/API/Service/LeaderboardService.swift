//
//  LeaderboardService.swift
//  QuizApp
//
//  Created by Lorena Boroš on 18/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class LeaderboardService {
    
    func fetchLeaderboardList(quizId: Int, completion: @escaping (([PlayerScoreResponse]?) -> Void)) {
        let urlString = "https://iosquiz.herokuapp.com/api/score"
        
        if let url = URL(string: urlString) {
            
            var urlComponents = URLComponents(string: urlString)!
            
            urlComponents.queryItems = [
                URLQueryItem(name: "quiz_id", value: String(quizId))
            ]
            
            var request = URLRequest(url: urlComponents.url!)
            
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let userDefaults = UserDefaults.standard
            guard let value = userDefaults.string(forKey: "authToken") else {
                return
            }
            request.addValue(value, forHTTPHeaderField: "Authorization")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let scores = try decoder.decode([PlayerScoreResponse].self, from: data)
                        completion(scores)
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
}
