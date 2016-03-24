//
//  LineSamplePreview.swift
//  Controls
//
//  Created by Jordan Davis on 2/3/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class LineSamplePreview: UIView {
    var _redColor: CGFloat?
    var _greenColor: CGFloat?
    var _blueColor: CGFloat?
    var _lineCap: CGLineCap?
    var _lineJoin: CGLineJoin?
    var _lineWidth: CGFloat?
    var _alphaColor: CGFloat?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //Draws The TopBar
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //context
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        //remove old line
        CGContextClearRect(context, bounds)
        
        //set line type
        CGContextSetLineWidth(context, lineWidth)
        CGContextSetRGBStrokeColor(context, redColor/255, greenColor/255, blueColor/255, alphaColor/255)
        CGContextSetLineJoin(context, lineJoin)
        CGContextSetLineCap(context, lineCap)
        
        //Draw sample line path
        CGContextMoveToPoint(context, bounds.width * 0.2 , bounds.height * 0.667 )
        CGContextAddLineToPoint(context, bounds.width * 0.2, bounds.height * 0.333)
        CGContextAddLineToPoint(context, bounds.width * 0.3, bounds.height * 0.333)
        CGContextAddLineToPoint(context, bounds.width * 0.4, bounds.height * 0.667)
        CGContextAddLineToPoint(context, bounds.width * 0.5, bounds.height * 0.667)
        CGContextAddLineToPoint(context, bounds.width * 0.6, bounds.height * 0.333)
        CGContextAddLineToPoint(context, bounds.width * 0.8, bounds.height * 0.5)
        CGContextAddLineToPoint(context, bounds.width * 0.85, bounds.height * 0.5)
        
        //Draw All
        CGContextStrokePath(context)
        
    }
    
    //get set line width
    var lineWidth: CGFloat {
        get{return _lineWidth!}
        set{
            _lineWidth = newValue
            setNeedsDisplay()
        }
    }
    
    //get set line join
    var lineJoin: CGLineJoin {
        get{return _lineJoin!}
        set{
            _lineJoin = newValue
            setNeedsDisplay()
        }
    }
    
    //get set line cap
    var lineCap: CGLineCap {
        get{return _lineCap!}
        set{
            _lineCap = newValue
            setNeedsDisplay()
        }
    }
    
    //get set red color
    var redColor: CGFloat {
        get{return _redColor!}
        set{
            _redColor = newValue
            setNeedsDisplay()
        }
    }
    
    //get set green color
    var greenColor: CGFloat {
        get{return _greenColor!}
        set{
            _greenColor = newValue
            setNeedsDisplay()
        }
    }
    
    //get set blue color
    var blueColor: CGFloat {
        get{return _blueColor!}
        set{
            _blueColor = newValue
            setNeedsDisplay()
        }
    }
    
    //get set alpha color
    var alphaColor: CGFloat {
        get{return _alphaColor!}
        set{
            _alphaColor = newValue
            setNeedsDisplay()
        }
    }
    
}
