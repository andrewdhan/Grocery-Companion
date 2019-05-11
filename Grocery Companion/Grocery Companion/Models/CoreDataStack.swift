//
//  CoreDataStack.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 5/10/19.
//  Copyright © 2019 Andrew Dhan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GroceryModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Failed to load persistent store: \(error)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    
    var mainContext: NSManagedObjectContext{
        return container.viewContext
    }
}
