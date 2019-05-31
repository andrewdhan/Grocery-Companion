//
//  StoreController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 11/1/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import Foundation
import MapKit
//temporary enum before incorporating Yelp API

enum StoreName: Int{
    case traderJoes = 0
    case wholeFoods = 1
}

class StoreController{
    init() {
        stores = [Store(name: "Trader Joe's", latitude:37.790780, longitude:-122.418039, context: moc), Store(name: "Whole Foods", latitude:37.781130,longitude:-122.399671, context: moc)]
    }
    
    //MARK: - Methods
    
    func estimatedCostForGroceries(store: Store, items: [Item]) -> Int? {

        guard let itemHistory = store.itemHistory as? [String:Int] else {return nil}
        
        let price = items.compactMap { (item) -> Int? in
            guard let name = item.name else {return nil}
            return itemHistory[name]
            }.reduce(0) { (result, value) -> Int in
                return result + value
        }
        
        return price
    }

    func itemsAvailableFrom(items: [Item]){

    }

    func averageStoreCoordinate() ->CLLocationCoordinate2D?{
        let stores = StoreController.shared.stores
        guard !stores.isEmpty else {return nil}
        let avgLatitude =  stores.reduce(0) {$0 + $1.coordinate.latitude}/Double(stores.count)
        let avgLongitude = stores.reduce(0) {$0 + $1.coordinate.longitude}/Double(stores.count)
        return CLLocationCoordinate2D(latitude: avgLatitude, longitude: avgLongitude)
    }



    //MARK: - Properties
    private let moc = CoreDataStack.shared.mainContext
    static let shared = StoreController()
    
    let stores = [Store]()
}
