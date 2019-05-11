//
//  GroceryController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import Foundation
import CoreData

private let moc =  CoreDataStack.shared.mainContext

class GroceryItemController {
    static let shared = GroceryItemController()
    
    //MARK: - CRUD Methods
    
    func addItem( name: String, price: Double?=nil, addToList: Bool, context: NSManagedObjectContext = moc){

        var centValue:Int? = nil
        
        if let price = price {
            centValue = Int(price*100)
        }
        
        let item = Item(name: name, centValue: centValue, context: context)
        
        item.isInList = addToList
        
        context.saveToPersistentStore()
    }

    func deleteItem(item:Item, context: NSManagedObjectContext = moc){
        moc.delete(item)
        context.saveToPersistentStore()
    }
    
    func checkOffItem(item: Item, context: NSManagedObjectContext = moc){
        item.isChecked = true
        context.saveToPersistentStore()
    }
    
    
    // TODO: - Implement clear all checks method
    
    //MARK: - Getter Method
    
    func getItemWithName(_ name: String, context: NSManagedObjectContext = moc) -> Item?{
        let request:NSFetchRequest<Item> = NSFetchRequest(entityName: "GroceryModel")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try context.fetch(request) as! Item
            return result
        }
        catch {
            return nil
        }
        
    }
    
    //MARK: - Private Methods

    
    
}
