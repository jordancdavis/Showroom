//
//  PaintView.swift
//  Showroom
//
//  Created by Jordan Davis on 2/20/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

//PaintViewDelegate
protocol PaintViewDelegate: class{
    //send image to viewController.
    func paintView(paintView: PaintView, updateImage image: UIImage)
}

class PaintView: UIView {
    
    weak var paintViewDelegate: PaintViewDelegate? = nil
    
    var drawImage: UIImage?                // Image to cache previous paths
    private var _drawing: [UIImage] = []   //keep images for undo
    private var _undone: [UIImage] = []    //keep undone images for redo
    private var _points = [CGPoint]()      // All touch points
    private let _path = UIBezierPath()     // Path to draw
    var shouldClear = false                // Whether to clear current image

    //Set Stroke Properties.
    private var _lineChooser = LineChooser()
    private var _lineCap: CGLineCap = .Round
    private var _lineJoin: CGLineJoin = .Round
    private var _lineWidth: CGFloat = 10.0
    private var _redColor: Float = 0
    private var _greenColor: Float = 0
    private var _blueColor: Float = 255
    private var _alphaColor: Float = 255
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteColor()
        _path.lineCapStyle = lineCap
        _path.lineJoinStyle = lineJoin
        _path.lineWidth = lineWidth
        drawImage = UIGraphicsGetImageFromCurrentImageContext()
        paintViewDelegate?.paintView(self, updateImage: drawImage!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let loc = touch.locationInView(self)
        _points.append(loc)
        setNeedsDisplay()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        for coalescedTouch in event!.coalescedTouchesForTouch(touch)! {
            _points.append(coalescedTouch.locationInView(self))
        }
        setNeedsDisplay()
    }
    
    // Take a snapshot of the current view and store it in drawImage before emptying the array
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        //set image to view.
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        drawViewHierarchyInRect(bounds, afterScreenUpdates: false)
        drawImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        _points.removeAll()
       
        //only save 20 most recent Images for memory purpose.
        if(_drawing.count > 20){
            _drawing.removeFirst()
        }
        
        //add immage to list, reset undone
        _drawing.append(drawImage!)
        _undone = []
        
        // Notify other objects that a stroke as added to the painting
        paintViewDelegate?.paintView(self, updateImage: drawImage!)
    }
    
    
    //Saves Canvas from unwanted Interuptions
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        touchesEnded(touches!, withEvent: event)
        setNeedsDisplay()
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        drawViewHierarchyInRect(bounds, afterScreenUpdates: false)
        drawImage = UIGraphicsGetImageFromCurrentImageContext()
        paintViewDelegate?.paintView(self, updateImage: drawImage!)

    }
    
    //Allows shake to earase the Canvas
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            shouldClear = true
            _drawing = []
            _undone = []
            _points = []
            setNeedsDisplay()
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
            drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
            drawImage = UIGraphicsGetImageFromCurrentImageContext()
            paintViewDelegate?.paintView(self, updateImage: drawImage!)
        }
    }
    

    // MARK: - DRAW
    override func drawRect(rect: CGRect) {
        

        // Erase Canvas
        guard shouldClear != true else {
            UIColor.whiteColor().setFill()
            UIRectFill(rect)
            shouldClear = false
            return
        }
        
        //Draw Canvas
        let context = UIGraphicsGetCurrentContext()
        CGContextSetAllowsAntialiasing(context, true)
        CGContextSetShouldAntialias(context, true)
        drawImage!.drawInRect(rect)
        updatePainting()
    }
    

    //Method to draw stroke and capture image
    func updatePainting() {
        
        //set stroke type
        _path.lineWidth = lineWidth
        _path.lineCapStyle = lineCap
        _path.lineJoinStyle = lineJoin
        UIColor.init(colorLiteralRed: redColor/255, green: greenColor/255, blue: blueColor/255, alpha: alphaColor/255).setStroke()
        _path.removeAllPoints()
        
        //trace list of points
        if !_points.isEmpty {
            _path.moveToPoint(_points.first!)
            // Iterate through the remaining touch points except for the last one
            for paintIndex in 0..<_points.count - 1 {
                _path.addLineToPoint(_points[paintIndex])
            }
            _path.addLineToPoint(_points.last!)
            _path.stroke()
        }
    }

    
    // MARK: - get/set
    //get set line width
    var lineWidth: CGFloat {
        get{return _lineWidth}
        set{
            _lineWidth = newValue
            setNeedsDisplay()
        }
    }
    
    //get set line join
    var lineJoin: CGLineJoin {
        get{return _lineJoin}
        set{
            _lineJoin = newValue
            setNeedsDisplay()
        }
    }
    
    //get set line cap
    var lineCap: CGLineCap {
        get{return _lineCap}
        set{
            _lineCap = newValue
            setNeedsDisplay()
        }
    }
    
    //get set red color
    var redColor: Float {
        get{return _redColor}
        set{
            _redColor = newValue
            setNeedsDisplay()
        }
    }
    
    //get set green color
    var greenColor: Float {
        get{return _greenColor}
        set{
            _greenColor = newValue
            setNeedsDisplay()
        }
    }
    
    //get set blue color
    var blueColor: Float {
        get{return _blueColor}
        set{
            _blueColor = newValue
            setNeedsDisplay()
        }
    }
    
    //get set alpha color
    var alphaColor: Float {
        get{return _alphaColor}
        set{
            _alphaColor = newValue
            setNeedsDisplay()
        }
    }

    //get list of recent drawing images
    var drawing: [UIImage]{
        get{ return _drawing}
        set {
            _drawing = newValue
            setNeedsDisplay()
        }
    }
    
    //get/set undone list
    var undone: [UIImage]{
        get{ return _undone}
        set {
            _undone = newValue
            setNeedsDisplay()
        }
    }
    
    //get/set current image
    var drawingPreviewImage: UIImage {
        get {return drawImage!}
        set {
            drawImage = newValue
            paintViewDelegate?.paintView(self, updateImage: drawImage!)
            setNeedsDisplay()
        }
    }
}
