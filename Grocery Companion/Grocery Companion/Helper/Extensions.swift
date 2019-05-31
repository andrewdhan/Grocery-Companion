//
//  Extensions.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension String{
    func toDate(withFormat format: DateFormatter.Style) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = format
        return dateFormatter.date(from: self)
    }
    
    func isDouble() -> Bool{
        if Double(self) == nil {
            return false
        } else {
            return true
        }
    }
}

//assumes int represents centvalue and converts to string representation of dollar price
extension Int {
    func centValueToDollarString() -> String?{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let dollarValue = Double(self)/10.00
        return formatter.string(from: NSNumber(value: dollarValue))
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


extension NSNumber{
    func currencyString() -> String?{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: self)
    }
}

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}
extension UIImage.Orientation {
    init(_ cgOrientation: UIImage.Orientation) {
        switch cgOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}

extension NSManagedObjectContext{
    func saveToPersistentStore(){
        self.perform {
            do{
                try self.save()
            } catch {
                NSLog("Trouble saving: \(error)")
                self.reset()
            }
        }
    }
}
