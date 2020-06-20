//
//  Queestion+CoreDataClass.swift
//  QuizApp
//
//  Created by Lorena Boroš on 22/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(QuestionEntity)
public class QuestionEntity: NSManagedObject {
    
    class func getEntityName() -> String {
        return "QuestionEntity"
    }
    
    class func mapToQuestionEntity(questions: [Question]) -> [QuestionEntity] {
        var questionEntities: [QuestionEntity] = []
        for q in questions {
            let questionEntity = QuestionEntity()
            questionEntity.id = q.id
            questionEntity.answers = q.answers
            questionEntity.correct_answer = q.correct_answer
            questionEntity.question = q.question
            questionEntities.append(questionEntity)
        }
        return questionEntities
    }
}
