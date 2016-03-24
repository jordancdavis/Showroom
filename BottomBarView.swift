//
//  BottomBarView.swift
//  Controls
//
//  Created by Jordan Davis on 2/3/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class BottomBarView: UIView {
    
    //Draws The BottomBar
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //context
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        //create path
        let barPath:UIBezierPath = UIBezierPath()
        barPath.moveToPoint(CGPoint(x: bounds.width, y: bounds.height))
        barPath.addLineToPoint(CGPoint(x: 110, y: bounds.height))
        barPath.addQuadCurveToPoint(CGPoint(x: bounds.origin.x, y: bounds.origin.y), controlPoint: CGPoint(x: bounds.origin.x, y: bounds.height))
        barPath.addLineToPoint(CGPoint(x: 90, y: bounds.origin.y))
        barPath.addQuadCurveToPoint(CGPoint(x: 140, y: bounds.height-10), controlPoint: CGPoint(x: 90, y: bounds.height-10))
        barPath.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height-10))
        barPath.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height))
        
        
        //DrawBar
        CGContextSetRGBFillColor(context, 255/255, 153/255, 75/255, 255)
        CGContextAddPath(context, barPath.CGPath)
        CGContextFillPath(context)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}