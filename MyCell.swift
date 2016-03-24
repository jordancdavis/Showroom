//
//  MyCell.swift
//  Showroom
//
//  Created by Jordan Davis on 2/23/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    var paintingView: UIView?
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        paintingView = UIView(frame: CGRectMake(0,0,bounds.width, bounds.height))
        paintingView?.backgroundColor = UIColor.whiteColor()
        self.addSubview(paintingView!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        updatePainting(Painting())
    }
    
    override func layoutSubviews() {
        paintingView?.frame = self.bounds
    }
    
    func updatePainting(painting: Painting) {
        let cellView: UIImageView = UIImageView(image: painting.paintingImage)
        cellView.frame = self.bounds
        paintingView?.addSubview(cellView)
    }
}
