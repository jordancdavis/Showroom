//
//  TopBarView.swift
//  Controls
//
//  Created by Jordan Davis on 2/3/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    
    //Draws The TopBar
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //context
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        //draw path
        let barPath:UIBezierPath = UIBezierPath()
        barPath.moveToPoint(CGPoint(x: bounds.width, y: bounds.origin.y))
        barPath.addLineToPoint(CGPoint(x: bounds.width, y: 10))
        barPath.addLineToPoint(CGPoint(x: 140, y: 10))
        barPath.addQuadCurveToPoint(CGPoint(x: 90, y: bounds.height), controlPoint: CGPoint(x: 90, y: 10))
        barPath.addLineToPoint(CGPoint(x: bounds.origin.x, y: bounds.height))
        barPath.addQuadCurveToPoint(CGPoint(x: 110, y: bounds.origin.y), controlPoint: CGPoint(x: 0.0, y: 0.0))
        barPath.addLineToPoint(CGPoint(x: bounds.width, y: bounds.origin.y))
        
        //Draw All
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
