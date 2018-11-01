//
//  File.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 10/30/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import Foundation
import MapKit

class Store: NSObject, MKAnnotation{
    
    
    init(name: String, latitude: Double, longitude: Double){
        self.name = name
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    
    //MARK: - Properties
    let name: String
    var coordinate: CLLocationCoordinate2D

}
