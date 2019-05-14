//
//  Item+Convenience.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 5/10/19.
//  Copyright © 2019 Andrew Dhan. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    convenience init(name: String, centValue: Int? = nil,  context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        if let centValue = centValue {
        self.centValue = Int16(centValue)
        }
    }
    
    public var price:Double {
        return Double(centValue)/100.0
    }
}
