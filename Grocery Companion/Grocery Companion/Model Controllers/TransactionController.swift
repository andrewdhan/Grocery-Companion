//
//  TransactionController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/31/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

class TransactionController {
    static let shared = TransactionController()
    
    
    //MARK: - CRUD
    func loadItems(name: String, cost: Double, store: Store, date: Date, transactionID: UUID){
        let price = Price(value: cost.toNSNumber(), store: store, date: date, transactionID: transactionID)
        
        let item = groceryItemController.getItemWithName(name) ?? GroceryItem(name: name)
        
        item.priceHistory.append(price)
        
        loadedItems.append(item)
 
    }
    func create(store: Store, date: Date, total: Double, identifier: UUID){
        let new = Transaction(store: store, date: date, total: total, identifier: identifier, items: loadedItems)
        transactions.append(new)
        groceryItemController.allItems.append(contentsOf: loadedItems)
        loadedItems = []
    }
    //MARK: - Methods
    func clearLoadedItems(){
        loadedItems = []
    }
    
    //MARK: - Properties
    private let groceryItemController = GroceryItemController.shared
    var loadedItems = [GroceryItem]()
    var transactions = [Transaction]()
}
