//
//  KnobColorChooserView.swift
//  Controls
//
//  Created by Jordan Davis on 2/3/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class KnobColorChooserView: UIView {
    private var _redKnob: Knob!
    private var _blueKnob: Knob!
    private var _greenKnob: Knob!
    private var _alphaKnob: Knob!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        //create redknob and add as subview
        _redKnob = Knob()
        _redKnob.knobRedColor = 204
        _redKnob.knobGreenColor = 102
        _redKnob.knobBlueColor = 102
        _redKnob?.backgroundColor = UIColor.blackColor()
        _redKnob.layer.cornerRadius = 20
        _redKnob.value = 10
        addSubview(_redKnob!)
        
        //create greenknob and add as subview
        _greenKnob = Knob()
        _greenKnob.knobRedColor = 144
        _greenKnob.knobGreenColor = 238
        _greenKnob.knobBlueColor = 144
        _greenKnob?.backgroundColor = UIColor.blackColor()
        _greenKnob.layer.cornerRadius = 20
        _greenKnob.value = 10
        addSubview(_greenKnob!)
        
        //create blueknob and add as subview
        _blueKnob = Knob()
        _blueKnob.knobRedColor = 143
        _blueKnob.knobGreenColor = 143
        _blueKnob.knobBlueColor = 255
        _blueKnob?.backgroundColor = UIColor.blackColor()
        _blueKnob.layer.cornerRadius = 20
        _blueKnob.value = 10
        addSubview(_blueKnob!)
        
        //create alphaKnob and add as subview
        _alphaKnob = Knob()
        _alphaKnob.knobRedColor = 222
        _alphaKnob.knobGreenColor = 222
        _alphaKnob.knobBlueColor = 222
        _alphaKnob?.backgroundColor = UIColor.blackColor()
        _alphaKnob.layer.cornerRadius = 20
        _alphaKnob.value = 160
        addSubview(_alphaKnob!)
        
    }
    
    //positions the knobs on the layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //positioning
        var availableSpace: CGRect = bounds
        (_redKnob.frame, availableSpace ) = availableSpace.divide(availableSpace.height * 0.25, fromEdge: .MinYEdge)
        (_greenKnob.frame, availableSpace ) = availableSpace.divide(availableSpace.height * 0.33, fromEdge: .MinYEdge)
        (_blueKnob.frame, _alphaKnob.frame ) = availableSpace.divide(availableSpace.height * 0.5, fromEdge: .MinYEdge)
        
        //makes the right two endges rounded.
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.TopRight.union(.BottomRight), cornerRadii: CGSizeMake(10, 10)).CGPath
        layer.mask = maskLayer
    }
    
    
    //returns the knob
    var redKnob: Knob {return _redKnob!}
    var blueKnob: Knob {return _blueKnob!}
    var greenKnob: Knob {return _greenKnob!}
    var alphaKnob: Knob {return _alphaKnob!}
    
    //returns the red knob value
    var redColor: CGFloat{
        return _redKnob.value
    }
    
    //returns the blue knob value
    var blueColor: CGFloat{
        return _blueKnob.value
    }
    
    //returns the green knob value
    var greenColor: CGFloat{
        return _greenKnob.value
    }
    
    //returns the alpha knob value
    var alphaColor: CGFloat{
        return _alphaKnob.value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
