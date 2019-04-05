//
//  DetectedText.swift
//  Grocery Companion
//
//  Created by Andrew Dhan on 4/5/19.
//  Copyright © 2019 Andrew Dhan. All rights reserved.
//

import Foundation
import Vision

class DetectedText{
    
    init(ocrResult: String?, textObservation: VNTextObservation) {
        self.topLeft = textObservation.topLeft
        self.topRight = textObservation.topRight
        self.bottomLeft = textObservation.bottomLeft
        self.bottomRight = textObservation.bottomRight
        self.text = ocrResult
    }
    
    var text: String?
    var topLeft:CGPoint
    var topRight:CGPoint
    var bottomLeft:CGPoint
    var bottomRight:CGPoint
}
