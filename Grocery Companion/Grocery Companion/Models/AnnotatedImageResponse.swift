//
//  AnnotatedImageResponse.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 4/9/19.
//  Copyright © 2019 Andrew Dhan. All rights reserved.
//

import Foundation
import CoreGraphics

struct AnnotatedImageResponse: Decodable{
    var responses: [Response]
    struct Response: Decodable{
        var textAnnotations: [TextAnnotation]
    }
    
}

struct TextAnnotation: Decodable{
    enum CodingKeys: String, CodingKey{
        case description
        case boundingPoly
        
        enum BoxCodingKeys: String, CodingKey{
            case vertices
            
            enum VertexCodingKeys: String, CodingKey{
                case x
                case y
            }
        }
    }
    
    init(from decoder: Decoder) throws{
        //create container for annotation and decode the text
        let annotationContainer = try decoder.container(keyedBy: CodingKeys.self)
        text = try annotationContainer.decode(String.self, forKey: .description)
        
        //create nested container for boundingPoly
        let boxContainer = try annotationContainer.nestedContainer(keyedBy: CodingKeys.BoxCodingKeys.self, forKey: .boundingPoly)
        //create nested container for vertices
        var verticesContainer = try boxContainer.nestedUnkeyedContainer(forKey: .vertices)
        //create array of vertices as CGPoints to store info from verticesContainer
        var vertices = [CGPoint]()
        //loops through verticesContainer, decode Vertex, and append initialized GCPoint to vertices array
        while !verticesContainer.isAtEnd{
            //decodes vertex
            let vertexContainer = try verticesContainer.nestedContainer(keyedBy: CodingKeys.BoxCodingKeys.VertexCodingKeys.self)
            let x = try vertexContainer.decode(Int.self, forKey:.x)
            let y = try vertexContainer.decode(Int.self, forKey: .y)
            //creates CGPoint and appends to vertices
            vertices.append(CGPoint(x: x, y: y))
        }
        
        topLeft = vertices[0]
        topRight = vertices[1]
        bottomRight = vertices[2]
        bottomLeft = vertices[3]
    }
    
    
    var text: String
    var topLeft: CGPoint
    var topRight: CGPoint
    var bottomLeft: CGPoint
    var bottomRight: CGPoint
}

/*
 AUTO Decoding
 struct AnnotatedImageResponse: Codable{
 var responses: [Response]
 }
 
 struct Response: Codable{
 var textAnnotations: [Annotation]
 //    var fullTextAnnotation: [FullAnnotation]
 }
 
 //Nested structs for TextAnnotations
 struct Annotation: Codable{
 var locale: String?
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
 
 struct FullAnnotation:Codable{
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
 */
