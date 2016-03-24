//
//  Knob.swift
//  Controls
//
//  Created by Jordan Davis on 1/25/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class Knob: UIControl {
    
    private var _knobRect: CGRect = CGRectZero
    private var _nibRect: CGRect = CGRectZero
    private var _value: CGFloat = 65
    private var _knobRedColor: CGFloat = 204
    private var _knobGreenColor: CGFloat = 102
    private var _knobBlueColor: CGFloat = 102
    private var _nibRedColor: CGFloat = 0
    private var _nibGreenColor: CGFloat = 0
    private var _nibBlueColor: CGFloat = 0
    
    
    //Register Touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        //moves the nib
        setNibPositionToTouch(touchPoint.x)
        sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    
    //Register Move
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        //moves the nib
        setNibPositionToTouch(touchPoint.x)
        sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    
    //Register End
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        //moves the nib
        setNibPositionToTouch(touchPoint.x)
        sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    
    //Draws The Knob and Nib
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        //KNOB size/location
        _knobRect = CGRectZero
        _knobRect.size.width = bounds.width*0.92
        _knobRect.size.height = bounds.height*0.9
        _knobRect.origin.x = 10
        _knobRect.origin.y = bounds.height * 0.5 - _knobRect.height * 0.5
        
        //make rounded rectangle path
        CGContextSaveGState(context)
        let knobPath = (UIBezierPath(roundedRect: CGRectMake(_knobRect.origin.x, _knobRect.origin.y, _knobRect.width, _knobRect.height), cornerRadius: 30)).CGPath
        
        //DrawKnob
        CGContextSetRGBFillColor(context, knobRedColor/255, knobGreenColor/255, knobBlueColor/255, 1)
        CGContextAddPath(context, knobPath)
        CGContextFillPath(context)
        CGContextRestoreGState(context)
        
        //NIB size/location
        _nibRect = CGRectZero
        _nibRect.size.width = 15
        _nibRect.size.height = max(_knobRect.width * 0.5, _knobRect.height * 0.5)
        
        //position nib
        _nibRect.origin.x = _knobRect.origin.x + value
        _nibRect.origin.y = _knobRect.origin.y + (_knobRect.height - _nibRect.height)*0.5
        
        //make rounded rectangle path
        CGContextSaveGState(context)
        
        //draw rounded rectangles for nibs
        let nibPath = (UIBezierPath(roundedRect: CGRectMake(_nibRect.origin.x, _nibRect.origin.y, _nibRect.width, _nibRect.height), cornerRadius: 10)).CGPath
        
        //DrawNib
        // CGContextSetFillColorWithColor(context, UIColor.lightGrayColor().CGColor)
        CGContextSetRGBFillColor(context, nibRedColor/255, nibGreenColor/255, nibBlueColor/255, 1)
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        CGContextAddPath(context, nibPath)
        CGContextFillPath(context)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
        
        
        //Draw All
        CGContextFillPath(context)
    }
    
    
    
    //adjust the nibs to that it represents the selected touch value
    func setNibPositionToTouch(touchPointX:CGFloat){
        value = touchPointX - 15
        if(value <= 10)
        {
            value = 10
        }
        if(touchPointX >= (_knobRect.origin.x + _knobRect.width - 10)-10)
        {
            value = (_knobRect.origin.x + _knobRect.width - _nibRect.width - 20)
        }
        
        _nibRect.origin.x = value
    }
    
    
    //gets and sets the value
    var value: CGFloat {
        get{return _value}
        set{
            _value = newValue
            setNeedsDisplay()
        }
    }
    
    //gets and sets the knob red value
    var knobRedColor: CGFloat {
        get{return _knobRedColor}
        set{
            _knobRedColor = newValue
            setNeedsDisplay()
        }
    }
    
    //gets and sets the knob green value
    var knobGreenColor: CGFloat {
        get{return _knobGreenColor}
        set{
            _knobGreenColor = newValue
            setNeedsDisplay()
        }
    }
    
    //gets and sets the knob blue value
    var knobBlueColor: CGFloat {
        get{return _knobBlueColor}
        set{
            _knobBlueColor = newValue
            setNeedsDisplay()
        }
    }
    
    //gets and sets the value
    var nibRedColor: CGFloat {
        get{return _nibRedColor}
        set{
            _nibRedColor = newValue
            setNeedsDisplay()
        }
    }
    
    //gets and sets the value
    var nibGreenColor: CGFloat {
        get{return _nibGreenColor}
        set{
            _nibGreenColor = newValue
            setNeedsDisplay()
        }
    }
    
    //gets and sets the value
    var nibBlueColor: CGFloat {
        get{return _nibBlueColor}
        set{
            _nibBlueColor = newValue
            setNeedsDisplay()
        }
    }
    
    

}




