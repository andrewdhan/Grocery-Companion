//
//  AnnotatedImageRequest.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 4/7/19.
//  Copyright © 2019 Andrew Dhan. All rights reserved.
//

import Foundation

struct AnnotatedImageRequest: Codable{
    var requests:[Request]
}
struct Request: Codable{
    var image: Image
    var features: [Feature]
}

struct Image: Codable{
    //image content needs to be base-64 encoded String
    var content: String
}

struct Feature:Codable{
    var type: String
    var maxResults: Int
}
