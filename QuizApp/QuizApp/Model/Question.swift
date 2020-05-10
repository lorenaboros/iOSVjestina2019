//
//  Question.swift
//  QuizApp
//
//  Created by Lorena Boroš on 25/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class Question: Decodable {
    var id: Int
    var question: String
    var answers: [String]
    var correct_answer: Int
}
