//
//  Extensions.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Dhan. All rights reserved.
//

import Foundation
import UIKit

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
