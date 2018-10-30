//
//  GroceryItem.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

class GroceryItem{
    init(name: String, lowestPrice: Price? = nil, priceHistory: [Price] = [Price]()) {
        self.name = name
        self.lowestPrice = lowestPrice
        self.priceHistory = priceHistory
    }
    
    //MARK: - Properties
    let name: String
    let lowestPrice: Price?
    let priceHistory: [Price]
}
