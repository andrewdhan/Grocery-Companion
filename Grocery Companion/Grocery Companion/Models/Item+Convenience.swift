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
    convenience init(name: String, isChecked: Bool = false, isInList: Bool = true,  context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = name
        self.isChecked = isChecked
        self.isInList = isInList
    }
}
