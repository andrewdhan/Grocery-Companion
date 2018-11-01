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
    //MARK: - Helpful Method
    
    func getPriceWithID(transactionID: UUID) -> Price?{
        for price in priceHistory{
            if price.transactionID == transactionID{
                return price
            }
        }
        return nil
    }
    func cheapestPlaceToBuy() -> Store?{
        let relevantPrices: [Price]
        if priceHistory.count < 3 {
            relevantPrices = priceHistory
        } else {
            let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
             relevantPrices = priceHistory.compactMap{ $0.date > monthAgo ?  $0 : nil
            }
        }
        let sortedList = relevantPrices.sorted {$0.value.doubleValue < $1.value.doubleValue}
        return sortedList.first?.store
    }
    
    func cheapestPriceForStore(store: Store, limitResult: Bool = false, monthRange: Int = 1) -> Double?{
        
        var prices = priceHistory.filter{$0.store == store}
        
        if limitResult{
            let date = Calendar.current.date(byAdding: .month, value: monthRange, to: Date())!
            prices = prices.filter{$0.date > date}
        }
        
        return prices.sorted {$0.value.doubleValue < $1.value.doubleValue}.first?.value.doubleValue
        
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
