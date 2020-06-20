//
//  Queestion+CoreDataProperties.swift
//  QuizApp
//
//  Created by Lorena Boroš on 22/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import CoreData

extension QuestionEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }
    
    @NSManaged public var id: Int
    @NSManaged public var correct_answer: Int
    @NSManaged public var question: String
    @NSManaged public var answers: [String]
}
