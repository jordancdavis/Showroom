//
//  PaintingViewController.swift
//  Painting
//
//  Created by Jordan Davis on 2/20/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

//PaintViewControllerDelegate
protocol PaintViewControllerDelegate: class{
    func updateImage(paintView: PaintView, updateImage image: UIImage, index: Int)
    func deletePaintingDelegate(index: Int)
}

class PaintingViewController: UIViewController, PaintViewDelegate{
    
    weak var pvcDelegate: PaintViewControllerDelegate? = nil
    private var knobColorChooserView: KnobColorChooserView?
    private var sidePanelView: SidePanelView?
    private var widthView: UISlider?
    private var lineSample: LineSamplePreview?
    private var controlsViewController: UIViewController?
    private var _paintview = PaintView()
    var paintingIndex: Int?
    var paintingImage: UIImage?

    var paintView: PaintView {
        return view as! PaintView
    }
    
    // MARK: - LOADING Override
    override func loadView() {
        //set View
        if(paintingImage == nil){
            _paintview.drawingPreviewImage = UIImage()
        }
        else{
            _paintview.drawingPreviewImage = paintingImage!
        }
        view = _paintview
        
        //crete buttons for Navigation Bar
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Brush", style: UIBarButtonItemStyle.Plain, target: self, action: "ChooseBrush:")
        let deleteButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "DeletePainting")
        let undoButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Rewind, target: self, action: "UndoStroke")
        let redoButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FastForward, target: self, action: "RedoStroke")
        deleteButton.tintColor = UIColor.redColor()
        self.navigationItem.rightBarButtonItem = deleteButton
        self.navigationItem.rightBarButtonItems?.append(editButton)
        self.navigationItem.rightBarButtonItems?.append(redoButton)
        self.navigationItem.rightBarButtonItems?.append(undoButton)        
        navigationController!.interactivePopGestureRecognizer!.enabled = false;

        self.paintView.paintViewDelegate = self
    }
    
    // MARK: - Navigation helper methods
    //Deletes a painting.
    func DeletePainting() {
        pvcDelegate!.deletePaintingDelegate(paintingIndex!)
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //restores painting from archive.
    func RedoStroke() {
        if(self.paintView.undone.count > 0){
            self.paintView.drawing.append(self.paintView.undone.popLast()!)
            self.paintView.drawingPreviewImage = self.paintView.drawing.last!
        }
        else{
            return
        }
    }
    
    //gets most recent painting archive
    func UndoStroke() {
        if(self.paintView.drawing.count > 1){
            self.paintView.undone.append(self.paintView.drawing.popLast()!)
            self.paintView.drawingPreviewImage = self.paintView.drawing.last!
        }
        else if(self.paintView.drawing.count == 1){
            self.paintView.undone.append(self.paintView.drawing.popLast()!)
            self.paintView.drawingPreviewImage = UIImage()
        }
        else{
            return
        }
    }

    // MARK: - override methods
    override func viewDidLoad() {
        paintView.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    // MARK: - Brush Chooser
    func ChooseBrush(sender: UIBarButtonItem) {
        //create view controller
        controlsViewController = UIViewController()
        controlsViewController!.view.backgroundColor = UIColor.blackColor()
        
        //drawing top and bottom bars
        ////////////////////////////////////////////////////////////////////////////////////
        let topBar = TopBarView(frame: CGRectMake(10,5,300,20))
        controlsViewController!.view.addSubview(topBar)
        
        
        //adds the side panel
        ////////////////////////////////////////////////////////////////////////////////////
        sidePanelView = SidePanelView(frame: CGRectMake(10,27,90,445))
        sidePanelView?.addTarget(self, action: "lineValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        sidePanelView?.setSelectedCap(_paintview.lineCap)
        sidePanelView?.setSelectedJoin(_paintview.lineJoin)
        controlsViewController!.view.addSubview(sidePanelView!)
        
        
        //adds color chooser
        ////////////////////////////////////////////////////////////////////////////////////
        knobColorChooserView = KnobColorChooserView(frame: CGRectMake(110,30,205,250))
        knobColorChooserView?.redKnob.addTarget(self, action: "colorValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        knobColorChooserView?.blueKnob.addTarget(self, action: "colorValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        knobColorChooserView?.greenKnob.addTarget(self, action: "colorValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        knobColorChooserView?.alphaKnob.addTarget(self, action: "colorValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        knobColorChooserView?.redKnob.value = CGFloat(_paintview.redColor / 1.65 + 10)
        knobColorChooserView?.greenKnob.value = CGFloat(_paintview.greenColor / 1.65 + 10)
        knobColorChooserView?.blueKnob.value = CGFloat(_paintview.blueColor / 1.65 + 10)
        knobColorChooserView?.alphaKnob.value = CGFloat(_paintview.alphaColor / 1.65 + 10)
        controlsViewController!.view.addSubview(knobColorChooserView!)
        
        //Adds The width slider
        ////////////////////////////////////////////////////////////////////////////////////
        widthView = UISlider(frame: CGRectMake(120,300,180,30))
        widthView?.value = Float(_paintview.lineWidth) / Float(50.0)
        widthView?.addTarget(self, action: "widthValueChanged", forControlEvents: UIControlEvents.ValueChanged)
        controlsViewController!.view.addSubview(widthView!)
        
        //Adds the sample Line
        ////////////////////////////////////////////////////////////////////////////////////
        lineSample = LineSamplePreview(frame: CGRectMake(100, 330, 210, 150))
        lineSample?.redColor = CGFloat(_paintview.redColor)
        lineSample?.greenColor = CGFloat(_paintview.greenColor)
        lineSample?.blueColor = CGFloat(_paintview.blueColor)
        lineSample?.alphaColor = CGFloat(_paintview.alphaColor)
        lineSample?.lineWidth = CGFloat(_paintview.lineWidth)
        lineSample?.lineJoin = _paintview.lineJoin
        lineSample?.lineCap = _paintview.lineCap

        //initialize line to defalt settings (value of other views)
        controlsViewController!.view.addSubview(lineSample!)
        
        //Adds The width slider
        ////////////////////////////////////////////////////////////////////////////////////
        let bottomBar = BottomBarView(frame: CGRectMake(10,475,300,20))
        controlsViewController!.view.addSubview(bottomBar)
        controlsViewController!.view.leftAnchor
        
        //paintingViewController.labelView.text = dataItem
        controlsViewController?.title = "Brush Chooser"
        navigationController?.pushViewController(controlsViewController!, animated: true)
    }
    
    
    // MARK: - Brush Helpers
    //changes line width
    func widthValueChanged() {
        lineSample!.lineWidth = CGFloat(((widthView?.value)! * 49.5) + 0.5)
        _paintview.lineWidth = (lineSample?.lineWidth)!
        lineSample?.setNeedsDisplay()
    }
    
    //changes line color
    func colorValueChanged(){
        lineSample!.redColor = CGFloat((knobColorChooserView?.redColor)! * 1.54)
        lineSample!.blueColor = CGFloat((knobColorChooserView?.blueColor)! * 1.54)
        lineSample!.greenColor = CGFloat((knobColorChooserView?.greenColor)! * 1.54)
        lineSample!.alphaColor = CGFloat((knobColorChooserView?.alphaColor)! * 1.54)
        _paintview.redColor = Float((lineSample?.redColor)!)
        _paintview.greenColor = Float((lineSample?.greenColor)!)
        _paintview.blueColor = Float((lineSample?.blueColor)!)
        _paintview.alphaColor = Float((lineSample?.alphaColor)!)
        
    }
    
    //changes line type
    func lineValueChanged(){
        lineSample!.lineJoin = (sidePanelView?.getJoin)!
        lineSample!.lineCap = (sidePanelView?.getCap)!
        _paintview.lineJoin = (lineSample?.lineJoin)!
        _paintview.lineCap = (lineSample?.lineCap)!
    }


    //MARK: - DELEGATE
    //send image from paintView to PaintingListViewController.
    func paintView(paintView: PaintView, updateImage image: UIImage) {
        pvcDelegate!.updateImage(paintView, updateImage: image, index: paintingIndex!)
    }
}