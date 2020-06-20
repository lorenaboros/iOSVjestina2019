//
//  Quiz+CoreDataClass.swift
//  QuizApp
//
//  Created by Lorena Boroš on 22/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(QuizEntity)
public class QuizEntity: NSManagedObject {
    
    class func getEntityName() -> String {
        return "QuizEntity"
    }
    
    class func firstOrCreate(withId id: Int) -> QuizEntity? {
        let context = DataController.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<QuizEntity> = QuizEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)
        request.returnsObjectsAsFaults = false
        
        do {
            let quizzes = try context.fetch(request)
            if let quizEntity = quizzes.first {
                return quizEntity
            } else {
                let newQuizEntity = QuizEntity(context: context)
                return newQuizEntity
            }
        } catch {
            return nil
        }
    }
    
    class func createFrom(quiz: Quiz) -> QuizEntity? {
        if
            let id = quiz.id as? Int,
            let category = quiz.category as? QuizCategory,
            let level = quiz.level as? Int,
            let quizDescription = quiz.description as? String,
            let questions = QuestionEntity.mapToQuestionEntity(questions: quiz.questions) as? [QuestionEntity],
            let image = quiz.image as? URL?,
            let title = quiz.title as? String {
            
            if let quiz = QuizEntity.firstOrCreate(withId: id) {
                quiz.id = id
                quiz.category = category.rawValue
                quiz.level = level
                quiz.quizDescription = quizDescription
                quiz.image = image?.absoluteString
                quiz.title = title
                quiz.questions = questions
                do {
                    let context = DataController.shared.persistentContainer.viewContext
                    try context.save()
                    return quiz
                } catch {
                    print("Failed saving")
                }
            }
        }
        return nil
    }
}
