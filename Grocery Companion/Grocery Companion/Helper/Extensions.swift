//
//  File.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation

extension Double{
    func toNSNumber() -> NSNumber{
        return NSNumber(value: self)
    }
}

extension String{
    func toDate(withFormat format: DateFormatter.Style) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = format
        return dateFormatter.date(from: self)
    }
}
