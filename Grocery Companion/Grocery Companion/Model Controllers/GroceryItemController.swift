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
    
    func addItem(withName name: String, addToList: Bool){
        let item = Item(name: name, centValue: nil, context: moc)
        
        item.isInList = addToList
    }

    func checkOffItem(item: GroceryItem){
        let index = allItems.firstIndex(of: item)!
        allItems[index].isChecked = !allItems[index].isChecked
    }
    
    func clearCheckedItems(){
        for item in allItems {
            if item.isChecked {
                item.isChecked = false
                item.isInGroceryList = false
            }
        }
    }
    //MARK: - Getter Method
    
    func getItemWithName(_ name: String) -> GroceryItem?{
        let index = indexInAllItems(withName: name)
        if index < 0 {
            return nil
        } else {
            return allItems[index]
        }
    }
    
    //MARK: - Private Methods
    private func indexInAllItems(withName name: String) -> Int {
        for (index, item) in allItems.enumerated(){
            if item.name.lowercased() == name.lowercased(){
                return index
            }
        }
        return -1
    }
    
    //MARK: - Private Methods

    
    
}
