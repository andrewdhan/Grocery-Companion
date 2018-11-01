//
//  GroceryItem.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

class GroceryItem: Equatable{
    
    init(name: String, lowestPrice: Price? = nil, priceHistory: [Price] = [Price]()) {
        self.name = name
        self.priceHistory = priceHistory
        self.isInGroceryList = true
        self.isChecked = false
    }
    
    static func == (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
        return lhs.name == rhs.name &&
            lhs.lowestPrice == rhs.lowestPrice &&
            lhs.priceHistory == rhs.priceHistory
    }
    
    //MARK: - Properties
    let name: String
    var lowestPrice: Price?{
        if priceHistory.isEmpty{
            return nil
        } else {
            return priceHistory.sorted{$0.value.doubleValue < $1.value.doubleValue}.first!
        }
    }
    var priceHistory: [Price]
    var isChecked: Bool
    var isInGroceryList: Bool
}
