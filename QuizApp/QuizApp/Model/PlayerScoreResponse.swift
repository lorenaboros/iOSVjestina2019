//
//  PlayerScore.swift
//  QuizApp
//
//  Created by Lorena Boroš on 18/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class PlayerScoreResponse: Decodable {
    var username: String
    var score: String?
}
