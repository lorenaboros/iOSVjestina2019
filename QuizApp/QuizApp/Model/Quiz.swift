//
//  Quiz.swift
//  QuizApp
//
//  Created by Lorena Boroš on 26/04/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class Quiz: Decodable {
    
    var id: Int
    var title: String
    var description: String
    var category: QuizCategory
    var level: Int
    var image: URL?
    var questions: [Question]
}
