////
////  TransactionController.swift
////  Grocery Companion
////
////  Created by Andrew Dhan on 10/31/18.
////  Copyright © 2018 Andrew Dhan. All rights reserved.
////
//
//import Foundation
//
//class TransactionController {
//    static let shared = TransactionController()
//    
//    
//    //MARK: - CRUD
//    func loadItems(name: String, cost: Double, store: Store, date: Date, transactionID: UUID){
//        let price = Price(value: cost.toNSNumber(), store: store, date: date, transactionID: transactionID)
//        
//        var item = groceryItemController.getItemWithName(name)
//        
//        if item == nil {
//            item = GroceryItem(name: name, inGroceryList: false)
//            newItems.append(item!)
//        }
//        
//        item!.priceHistory.append(price)
//        
//        loadedItems.append(item!)
// 
//    }
//    func create(store: Store, date: Date, total: Double, identifier: UUID){
//        let new = Transaction(store: store, date: date, total: total, identifier: identifier, items: loadedItems)
//        transactions.append(new)
//        groceryItemController.allItems.append(contentsOf: newItems)
//        clearLoadedItems()
//    }
//    //MARK: - Methods
//    func clearLoadedItems(){
//        loadedItems = []
//        newItems = []
//    }
//    
//    //MARK: - Properties
//    private let groceryItemController = GroceryItemController.shared
//    private var newItems = [GroceryItem]()
//    var loadedItems = [GroceryItem]()
//    var transactions = [Transaction]()
//}
