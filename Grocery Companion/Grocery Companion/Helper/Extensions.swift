//
//  Extensions.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
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

extension Dictionary{
    func convertToTupleArray() -> [(Key, Value)]{
        var result = [(Key,Value)]()
        for (key, value) in self {
            result.append((key,value))
        }
        return result
    }
}

extension Double {
    func currencyString() -> String?{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: self.toNSNumber())
    }
}

extension NSNumber{
    func currencyString() -> String?{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: self)
    }
}
