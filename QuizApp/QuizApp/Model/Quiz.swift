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
    
    init(title: String, description: String, image: URL, category: QuizCategory, level: Int, questions: [Question], id: Int) {
        self.title = title
        self.description = description
        self.image = image
        self.id = id
        self.category = category
        self.level = level
        self.questions = questions
    }
}
