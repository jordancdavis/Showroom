//
//  LineChooser.swift
//  Controls
//
//  Created by Jordan Davis on 1/25/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class LineChooser: UIView {
    
    private var _lineRect: CGRect = CGRectZero
    private var _boxRedColor: CGFloat = 147
    private var _boxGreenColor: CGFloat = 112
    private var _boxBlueColor: CGFloat = 219
    private var _linecolor: CGColor = UIColor.whiteColor().CGColor
    private var _join: CGLineJoin = CGLineJoin.Round
    private var _cap: CGLineCap = CGLineCap.Square
    private var _isAngle: Bool = false
    private var _currentlySelected: Bool = false
    private var _originalRedColor: CGFloat?
    private var _originalBlueColor: CGFloat?
    private var _originalGreenColor: CGFloat?

    
    
    //Draws The Knob and Nib
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        //line box size/location
        _lineRect = CGRectZero
        _lineRect.size.width = bounds.width
        _lineRect.size.height = bounds.height*0.90
        _lineRect.origin.x = 0.0
        _lineRect.origin.y = bounds.height * 0.5 - _lineRect.height * 0.5
        
        //drawline
        CGContextSetRGBFillColor(context, boxRedColor/255, boxGreenColor/255, boxBlueColor/255, 255)
        CGContextFillPath(context)
        CGContextFillRect(context, _lineRect)
        
        //Draw All
        CGContextFillPath(context)
        
        //determines if type is line or angle and how to draw it
        if(!isAngle){ //draws a line
            CGContextSetLineWidth(context, 20)
            CGContextSetLineJoin(context, join)
            CGContextSetLineCap(context, cap)
            CGContextSetFillColorWithColor(context, linecolor)
            if(cap == CGLineCap.Butt ){
                CGContextMoveToPoint(context, _lineRect.origin.x + 15, _lineRect.size.height * 0.5)
                CGContextAddLineToPoint(context, _lineRect.width - 15, _lineRect.size.height * 0.5)
            } else {
                CGContextMoveToPoint(context, _lineRect.origin.x + 20, _lineRect.size.height * 0.5)
                CGContextAddLineToPoint(context, _lineRect.width - 20, _lineRect.size.height * 0.5)
            }
            CGContextStrokePath(context)
        } else { //draws an angle
            CGContextSetLineWidth(context, 20.0)
            CGContextSetLineJoin(context, join)
            CGContextSetLineCap(context, cap)
            CGContextSetFillColorWithColor(context, linecolor)
            CGContextMoveToPoint(context, _lineRect.origin.x + 25, _lineRect.size.height * 0.667)
            CGContextAddLineToPoint(context, (_lineRect.width) * 0.5, _lineRect.size.height * 0.333)
            CGContextAddLineToPoint(context, _lineRect.width - 25, _lineRect.size.height * 0.667)
            CGContextStrokePath(context)
        }
    }
    
    //allows a type to be selected and hylighted when selected.
    func selectLine(){
        if(_currentlySelected){
            boxRedColor = _originalRedColor!
            boxGreenColor = _originalGreenColor!
            boxBlueColor = _originalBlueColor!
            _currentlySelected = false
        }
        else{
            _originalRedColor = boxRedColor
            _originalBlueColor = boxBlueColor
            _originalGreenColor = boxGreenColor
            boxRedColor = 255
            boxGreenColor = 246
            boxBlueColor = 143
            _currentlySelected = true
        }
        setNeedsDisplay()
    }
    
    
    //get and set box color
    var boxRedColor: CGFloat {
        get{return _boxRedColor}
        set{
            _boxRedColor = newValue
            setNeedsDisplay()
        }
    }
    
    
    //get and set box color
    var boxBlueColor: CGFloat {
        get{return _boxBlueColor}
        set{
            _boxBlueColor = newValue
            setNeedsDisplay()
        }
    }
    
    //get and set box color
    var boxGreenColor: CGFloat {
        get{return _boxGreenColor}
        set{
            _boxGreenColor = newValue
            setNeedsDisplay()
        }
    }
    
    
    //get and set line color
    var linecolor: CGColor {
        get{return _linecolor}
        set{
            _linecolor = newValue
            setNeedsDisplay()
        }
    }
    
    //get and set join type
    var join: CGLineJoin {
        get{return _join}
        set{
            _join = newValue
            setNeedsDisplay()
        }
    }
    
    //get and set cap type
    var cap: CGLineCap {
        get{return _cap}
        set{
            _cap = newValue
            setNeedsDisplay()
        }
    }
    
    //distinguishes caps from joins
    var isAngle: Bool {
        get{return _isAngle}
        set{
            _isAngle = newValue
            setNeedsDisplay()
        }
    }
    
    //determines if line type is current selection
    var isCurrentlySelected: Bool {
        get{return _currentlySelected}
        set{
            _currentlySelected = newValue
            setNeedsDisplay()
        }
    }
    
}