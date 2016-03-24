//
//  SidePanelView.swift
//  Controls
//
//  Created by Jordan Davis on 2/3/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class SidePanelView: UIControl {
    private var _stroke1: LineChooser!
    private var _stroke2: LineChooser!
    private var _stroke3: LineChooser!
    private var _filler: UIView!
    private var _pointAngle: LineChooser!
    private var _curvedAngle: LineChooser!
    private var _flatAngle: LineChooser!
    
    
    //create 6 LineChoosers (3 cap / 3 joins) and add as subview
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //create square cap
        _stroke1 = LineChooser()
        _stroke1.boxRedColor = 204
        _stroke1.boxGreenColor = 153
        _stroke1.boxBlueColor = 204
        _stroke1.cap = CGLineCap.Square
        _stroke1.linecolor = UIColor.blackColor().CGColor
        _stroke1?.backgroundColor = UIColor.blackColor()
        addSubview(_stroke1!)
        
        //create round cap
        _stroke2 = LineChooser()
        _stroke2.boxRedColor = 204
        _stroke2.boxGreenColor = 153
        _stroke2.boxBlueColor = 204
        _stroke2.cap = CGLineCap.Round
        _stroke2.linecolor = UIColor.blueColor().CGColor
        _stroke2?.backgroundColor = UIColor.blackColor()
        addSubview(_stroke2!)
        
        //create butt cap
        _stroke3 = LineChooser()
        _stroke3.boxRedColor = 204
        _stroke3.boxGreenColor = 153
        _stroke3.boxBlueColor = 204
        _stroke3.cap = CGLineCap.Butt
        _stroke3.linecolor = UIColor.blackColor().CGColor
        _stroke3?.backgroundColor = UIColor.blackColor()
        addSubview(_stroke3!)
        
        //create empty filler
        _filler = UIView(frame: CGRectMake(0,0,bounds.width, bounds.height * 0.5))
        let orangeColor = UIColor(red: 255/255, green: 153/255, blue: 75/255, alpha: 255)
        _filler.backgroundColor = orangeColor
        addSubview(_filler)

        
        //create pointed angle
        _pointAngle = LineChooser()
        _pointAngle.boxRedColor = 204
        _pointAngle.boxGreenColor = 102
        _pointAngle.boxBlueColor = 102
        _pointAngle.isAngle = true
        _pointAngle.join = CGLineJoin.Miter
        _pointAngle?.backgroundColor = UIColor.blackColor()
        addSubview(_pointAngle!)
        
        //create rounded angle
        _curvedAngle = LineChooser()
        _curvedAngle.boxRedColor = 204
        _curvedAngle.boxGreenColor = 102
        _curvedAngle.boxBlueColor = 102
        _curvedAngle.isAngle = true
        _curvedAngle.join = CGLineJoin.Round
        _curvedAngle?.backgroundColor = UIColor.blackColor()
        addSubview(_curvedAngle!)
        
        //create flatAngle
        _flatAngle = LineChooser()
        _flatAngle.boxRedColor = 204
        _flatAngle.boxGreenColor = 102
        _flatAngle.boxBlueColor = 101
        _flatAngle.isAngle = true
        _flatAngle.join = CGLineJoin.Bevel
        _flatAngle?.backgroundColor = UIColor.blackColor()
        addSubview(_flatAngle!)
        
        //pre-set these LineChoosers
        _curvedAngle.selectLine()
        _stroke2.selectLine()
        
    }
    
    //I dont knwo what this does. but it hasnt been implemented
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //manages how LineChoosers are layed out.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //positions the LineChoosers
        var availableSpace: CGRect = bounds
        (_stroke1.frame, availableSpace ) = availableSpace.divide(availableSpace.height * 0.1667, fromEdge: .MinYEdge)
        (_stroke2.frame, availableSpace ) = availableSpace.divide(availableSpace.height * 0.195, fromEdge: .MinYEdge)
        (_stroke3.frame, availableSpace ) = availableSpace.divide(availableSpace.height * 0.237, fromEdge: .MinYEdge)
        (_filler.frame, availableSpace ) = availableSpace.divide(availableSpace.height * 0.05, fromEdge: .MinYEdge)
        (_pointAngle.frame, availableSpace  ) = availableSpace.divide(availableSpace.height * 0.333, fromEdge: .MinYEdge)
        (_curvedAngle.frame, _flatAngle.frame  ) = availableSpace.divide(availableSpace.height * 0.5, fromEdge: .MinYEdge)
    }
    
    //returns the LineChooser
    var stroke1: LineChooser {return _stroke1!}
    var stroke2: LineChooser {return _stroke2!}
    var stroke3: LineChooser {return _stroke3!}
    var pointAngle: LineChooser {return _pointAngle!}
    var flatAngle: LineChooser {return _flatAngle!}
    var curvedAngle: LineChooser {return _curvedAngle!}
    
    
    //returns the join type
    var getJoin:CGLineJoin {
        if(_flatAngle.isCurrentlySelected){
            return CGLineJoin.Bevel
        } else if(_curvedAngle.isCurrentlySelected){
            return CGLineJoin.Round
        } else {
            return CGLineJoin.Miter
        }
    }
    
    //returns the cap type
    var getCap:CGLineCap {
        if(_stroke3.isCurrentlySelected){
            return CGLineCap.Butt
        } else if(_stroke2.isCurrentlySelected){
            return CGLineCap.Round
        } else {
            return CGLineCap.Square
        }
    }
    
    
    //Register Touch to select join and cap
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        //selects cap type. limits to only 1
        if(touchPoint.y < 75){
            if(!_stroke1.isCurrentlySelected){
                _stroke1.selectLine()
            }
            if(_stroke2.isCurrentlySelected){
                _stroke2.selectLine()
            }
            if(_stroke3.isCurrentlySelected){
                _stroke3.selectLine()
            }
        } else if (touchPoint.y < 150){
            if(!_stroke2.isCurrentlySelected){
                _stroke2.selectLine()
            }
            if(_stroke3.isCurrentlySelected){
                _stroke3.selectLine()
            }
            if(_stroke1.isCurrentlySelected){
                _stroke1.selectLine()
            }
        } else if (touchPoint.y < 225){
            if(!_stroke3.isCurrentlySelected){
                _stroke3.selectLine()
            }
            if(_stroke2.isCurrentlySelected){
                _stroke2.selectLine()
            }
            if(_stroke1.isCurrentlySelected){
                _stroke1.selectLine()
            }
        }
        
        
        //selects join type. limits to only one.
        if(touchPoint.y > 225 && touchPoint.y < 300){
            if(!_pointAngle.isCurrentlySelected){
                _pointAngle.selectLine()
            }
            if(_curvedAngle.isCurrentlySelected){
                _curvedAngle.selectLine()
            }
            if(_flatAngle.isCurrentlySelected){
                _flatAngle.selectLine()
            }
        } else if (touchPoint.y > 300 && touchPoint.y < 375){
            if(!_curvedAngle.isCurrentlySelected){
                _curvedAngle.selectLine()
            }
            if(_pointAngle.isCurrentlySelected){
                _pointAngle.selectLine()
            }
            if(_flatAngle.isCurrentlySelected){
                _flatAngle.selectLine()
            }
        } else if (touchPoint.y > 375 && touchPoint.y < bounds.height){
            if(!_flatAngle.isCurrentlySelected){
                _flatAngle.selectLine()
            }
            if(_curvedAngle.isCurrentlySelected){
                _curvedAngle.selectLine()
            }
            if(_pointAngle.isCurrentlySelected){
                _pointAngle.selectLine()
            }
        }
        
        sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
    }
    
    
    func setSelectedCap(cap :CGLineCap) {
        if(cap == CGLineCap.Square) {
            if(!_stroke1.isCurrentlySelected){
                _stroke1.selectLine()
            }
            if(_stroke2.isCurrentlySelected){
                _stroke2.selectLine()
            }
            if(_stroke3.isCurrentlySelected){
                _stroke3.selectLine()
            }
        } else if (cap == CGLineCap.Round){
            if(!_stroke2.isCurrentlySelected){
                _stroke2.selectLine()
            }
            if(_stroke3.isCurrentlySelected){
                _stroke3.selectLine()
            }
            if(_stroke1.isCurrentlySelected){
                _stroke1.selectLine()
            }
        } else {
            if(!_stroke3.isCurrentlySelected){
                _stroke3.selectLine()
            }
            if(_stroke2.isCurrentlySelected){
                _stroke2.selectLine()
            }
            if(_stroke1.isCurrentlySelected){
                _stroke1.selectLine()
            }
        }
    
}
    
        func setSelectedJoin(join: CGLineJoin){
            if(join == CGLineJoin.Round){
                if(!_curvedAngle.isCurrentlySelected){
                    _curvedAngle.selectLine()
                }
                if(_pointAngle.isCurrentlySelected){
                    _pointAngle.selectLine()
                }
                if(_flatAngle.isCurrentlySelected){
                    _flatAngle.selectLine()
                }
            }
            else if(join == CGLineJoin.Bevel){
                if(!_flatAngle.isCurrentlySelected){
                    _flatAngle.selectLine()
                }
                if(_curvedAngle.isCurrentlySelected){
                    _curvedAngle.selectLine()
                }
                if(_pointAngle.isCurrentlySelected){
                    _pointAngle.selectLine()
                }
            } else {
                if(!_pointAngle.isCurrentlySelected){
                    _pointAngle.selectLine()
                }
                if(_curvedAngle.isCurrentlySelected){
                    _curvedAngle.selectLine()
                }
                if(_flatAngle.isCurrentlySelected){
                    _flatAngle.selectLine()
                }
            }
            
            
        
    }
    

}
