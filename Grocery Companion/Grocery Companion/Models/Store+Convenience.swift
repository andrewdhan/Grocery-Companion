//
//  Store+Convenience.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 5/10/19.
//  Copyright © 2019 Andrew Dhan. All rights reserved.
//

import Foundation
import CoreData


extension Store{
    convenience init(name: String, latitude: Double, longitude: Double, isFavorite: Bool = false, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.isFavorite = isFavorite
    }
}
