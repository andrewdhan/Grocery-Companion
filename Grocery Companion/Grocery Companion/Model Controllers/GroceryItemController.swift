//
//  GroceryController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

class GroceryItemController {
    static let shared = GroceryItemController()
    
    init() {
        self.allItems = [GroceryItem]()
    }
    //MARK: - CRUD Methods
    
    func addItem(withName name: String){
        let index = indexInAllItems(withName: name)
        
        if index >= 0 {
            allItems[index].isInGroceryList = true
        } else {
            let newItem = GroceryItem(name: name, inGroceryList: true)
            allItems.append(newItem)
        }
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
            if item.name == name{
                return index
            }
        }
        return -1
    }
    
    //MARK: - Properties
     var groceryList: [GroceryItem] {
        return allItems.filter{$0.isInGroceryList == true}
    }
     var allItems: [GroceryItem]
}
