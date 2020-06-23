//
//  DataController.swift
//  QuizApp
//
//  Created by Lorena Boroš on 18/06/2020.
//  Copyright © 2020 Lorena Boroš. All rights reserved.
//

import Foundation
import CoreData


class DataController {
    
    static let shared = DataController()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    

    func fetchQuizzess(searchParam: String) -> [QuizEntity]? {
        let request: NSFetchRequest<QuizEntity> = QuizEntity.fetchRequest()
        
        let titlePredicate = NSPredicate(format: "title LIKE '*%@*'", searchParam)
        let descriptionPredicate = NSPredicate(format: "quizDescription = %@", searchParam)
        let orPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.or, subpredicates: [titlePredicate, descriptionPredicate])
        
        request.predicate = orPredicate
        request.sortDescriptors = [NSSortDescriptor(key: "category", ascending: true)]
        
        let context = DataController.shared.persistentContainer.viewContext
        let quizzess = try? context.fetch(request)
        return quizzess
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
