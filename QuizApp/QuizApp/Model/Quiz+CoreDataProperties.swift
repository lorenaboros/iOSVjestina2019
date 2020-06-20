//
//  Quiz+CoreDataProperties.swift
//  QuizApp
//
//  Created by Lorena Boroš on 22/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import CoreData

extension QuizEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizEntity> {
        return NSFetchRequest<QuizEntity>(entityName: "QuizEntity")
    }
    
    @NSManaged public var title: String
    @NSManaged public var image: String?
    @NSManaged public var id: Int
    @NSManaged public var level: Int
    @NSManaged public var quizDescription: String
    @NSManaged public var category: String
    @NSManaged public var questions: [QuestionEntity]
}
