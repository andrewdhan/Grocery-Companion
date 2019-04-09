//
//  AnnotatedImageResponse.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 4/9/19.
//  Copyright © 2019 Andrew Dhan. All rights reserved.
//

import Foundation

struct AnnotatedImageResponse: Codable{
    var responses: [Response]
}

struct Response: Codable{
    var textAnnotations: [Annotation]
//    var fullTextAnnotation: [FullAnnotation]
}

//Nested structs for TextAnnotations
struct Annotation: Codable{
    var locale: String
    var description: String
    var boundingPoly: BoundingBox
}

struct BoundingBox: Codable{
    var vertices: [Vertex]
}

struct Vertex: Codable{
    var x: Int
    var y: Int
}

//                          Nested structs fo FullAnnotation

struct Full Annotation:Codable{
    var pages: [Page]
    var text: String
}

struct Page: Codable{
    var property: Property
    var blocks: [Block]
}

struct Property: Codable{
    var width: Int
    var height: Int
}

struct Block: Codable{
    var boundingBox: BoundingBox
    var paragraphs: [Paragraph]
    var blockType: String
    var confidence: Double
}

struct Paragraph: Codable{
    var boundingBox: BoundingBox
    var words: [Word]
    var confidence: Double
}

struct Word: Codable{
    var property: WordProperty
    var boundingBox: BoundingBox
    var symbols: Symbol
}

struct WordProperty: Codable{
    var detectedLanguages: Language

}

struct Language: Codable{
    var languageCode: String
}

struct Symbol: Codable{
    var property: Property
    var boundingBox: BoundingBox
    var text: String
    var confidence: Double
}
