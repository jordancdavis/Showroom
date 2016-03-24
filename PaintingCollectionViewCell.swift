//
//  PaintingCollectionViewCell.swift
//  Showroom
//
//  Created by Jordan Davis on 2/22/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class PaintingCollectionViewCell: UICollectionViewCell {
    var paintingView: UIView?
    var painting: Painting?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        paintingView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        paintingView!.contentMode = UIViewContentMode.ScaleAspectFit
        paintingView!.backgroundColor = UIColor.grayColor()
        contentView.addSubview(paintingView!)
        
        painting = Painting()
        paintingView!.addSubview(painting!)
        
        let paintingShield: UIView = UIView(frame: self.bounds)
        contentView.addSubview(paintingShield)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(painting: Painting){
        painting.frame = paintingView!.frame
        self.painting = painting
    }
}
