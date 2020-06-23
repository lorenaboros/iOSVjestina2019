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
    
    
}
