//
//  LoginResponse.swift
//  QuizApp
//
//  Created by Lorena Boroš on 02/05/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class LoginResponse {
    let token: String
    let user_id: Int
    
    init?(json: Any) {
        print(json)
        if let jsonDict = json as? [String: Any],
            let token = jsonDict["token"] as? String,
            let user_id = jsonDict["user_id"] as? Int {
            self.token = token
            self.user_id = user_id
        } else {
            return nil
        }
    }
}
