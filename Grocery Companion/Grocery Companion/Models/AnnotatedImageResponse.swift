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
        var vertices = [(Int,Int)]()
        //loops through verticesContainer, decode Vertex, and append initialized GCPoint to vertices array
        while !verticesContainer.isAtEnd{
            //decodes vertex
            let vertexContainer = try verticesContainer.nestedContainer(keyedBy: CodingKeys.BoxCodingKeys.VertexCodingKeys.self)
            let x = try vertexContainer.decode(Int.self, forKey:.x)
            let y = try vertexContainer.decode(Int.self, forKey: .y)
            //creates CGPoint and appends to vertices
            vertices.append((x,y))
        }
        
        topLeft = vertices[0]
        topRight = vertices[1]
        bottomRight = vertices[2]
        bottomLeft = vertices[3]
    }
    
    
    var text: String
    var topLeft: (Int,Int)
    var topRight: (Int,Int)
    var bottomLeft: (Int,Int)
    var bottomRight: (Int,Int)
    var bottomY:Double{
        return Double((bottomLeft.1+bottomRight.1)/2)
    }
    var topY:Double{
        return Double((topLeft.1+topRight.1)/2)
    }
}
