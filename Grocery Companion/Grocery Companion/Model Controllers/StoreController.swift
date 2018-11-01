//
//  StoreController.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 11/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

//temporary enum before incorporating Yelp API

enum StoreName: Int{
    case traderJoes = 0
    case wholeFoods = 1
}

class StoreController{
    static let shared = StoreController()
    
    static let stores =
        [Store(name: "Trader Joe's", latitude:37.790780, longitude:-122.418039),
         Store(name: "Whole Foods", latitude:37.781130,longitude:-122.399671)]
}
