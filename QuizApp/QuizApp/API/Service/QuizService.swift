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
}
