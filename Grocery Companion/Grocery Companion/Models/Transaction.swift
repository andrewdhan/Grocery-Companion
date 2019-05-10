//
//  Transaction.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import Foundation

class Transaction{
    init(store: Store, date: Date, total: Double, identifier: UUID, items: [GroceryItem]) {
        self.store = store
        self.date = date
        self.total = total.toNSNumber()
        self.identifier = identifier
        self.items = items
    }
    
    //Properties
    let store: Store
    let date: Date
    let total: NSNumber
    let identifier: UUID
    let items: [GroceryItem]
    
}
