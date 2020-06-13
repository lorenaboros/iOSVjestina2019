//
//  LoginService.swift
//  QuizApp
//
//  Created by Lorena Boroš on 26/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class LoginService {
    
    func loginUser(password: String, username: String, completion: @escaping ((LoginResponse?) -> Void)) {
        let url = "https://iosquiz.herokuapp.com/api/session"
        
        var urlComponents = URLComponents(string: url)!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "password", value: password)
        ]
        
        guard let urlURL = urlComponents.url else {
            return
        }
        var request = URLRequest(url: urlURL)
        request.httpMethod = "POST"
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let loginResponse = LoginResponse(json: json)
                    completion(loginResponse)
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
