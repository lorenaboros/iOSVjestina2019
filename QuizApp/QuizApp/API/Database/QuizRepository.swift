//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Lorena Boroš on 22/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation

class QuizRepository {
    
    private var quizzes: [Quiz]?
   
    func saveQuizzes(quizResponse: QuizResponse)-> [QuizEntity] {
        self.quizzes = quizResponse.quizzes
        var quizEntities: [QuizEntity] = []
        guard let quizzes = quizzes else {
            return []
        }
        for quiz in quizzes {
            let quizEntity = QuizEntity.createFrom(quiz: quiz)
            if let quizEntity = quizEntity {
                quizEntities.append(quizEntity)
            }
        }
        return quizEntities
    }
}
