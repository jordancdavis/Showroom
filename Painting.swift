//
//  Painting.swift
//  Showroom
//
//  Created by Jordan Davis on 2/20/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import Foundation
import UIKit

class Painting {
    
    var strokes: [Stroke]?
    var aspectRatio: Double?
    var _paintingImage: UIImage?

    init()
    {
        strokes = []
        aspectRatio = 1.0
        _paintingImage = UIImage()
    }
    
    func getStrokeAtIndex(StrokeIndex: Int) -> Stroke {
        return strokes![StrokeIndex]
    }
    
    func appendStroke(index: Int, stroke: Stroke) {
        strokes!.append(stroke)
    }
    
    var strokeCount: Int{
        return strokes!.count
    }
    
    var paintingImage: UIImage {
        get{ return _paintingImage!}
        set{
            _paintingImage = newValue
        }
    }
}

struct Stroke {
    var color: Color = Color()
    var points: [CGPoint] = []
    var lineCap: CGLineCap?
    var lineJoin: CGLineJoin?
    var lineWidth: Float?    
}

struct Color {
    var r: Float = 0.0
    var g: Float = 0.0
    var b: Float = 0.0
    var a: Float = 0.0
}

