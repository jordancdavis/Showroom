//
//  PaintGallery.swift
//  Showroom
//
//  Created by Jordan Davis on 2/20/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

protocol PaintingCollectionDelegate: class{
    //change the painting
    func collection(collection: PaintGallery, paintingChanged paintingIndex: Int)
    //func collection(collection: PaintGallery, addPainting painting: Painting)
    //func collection(collection: PaintGallery, removePainting paintingIndex: Int)
}

class PaintGallery {
    
    private var _paintingListViewController: PaintingListViewController?
    private var _paintings: [Painting] = []
    
    // MARK: - Indexing
    var paintingCount: Int {
        return _paintings.count
    }
    
    // MARK: - Element Access
    func addPainting(painting: Painting) {
        _paintings.append(painting)
    }
    
    func paintingAtIndex(paintingIndex: Int) -> Painting {
        return _paintings[paintingIndex]
    }
    
    func removePainting(paintingIndex: Int) {
        _paintings.removeAtIndex(paintingIndex)
    }
    
    func setPaintingImageToIndex(image: UIImage, index: Int){
        _paintings[index].paintingImage = image
        delegate?.collection(self, paintingChanged: index)
    }
    
    func getpaintingImageAtIndex(index: Int) -> UIImage {
        return _paintings[index].paintingImage
    }
    
    func addStroke(stroke: Stroke, toPainting index: Int){
        let painting: Painting = paintingAtIndex(index)
        painting.strokes!.append(stroke)
        delegate?.collection(self, paintingChanged: index)
    
    }
    
    var paintingListViewController: PaintingListViewController {
        get{ return _paintingListViewController! }
        set{
            _paintingListViewController = newValue
        }
    }
    
    // MARK: - EVENTS
    weak var delegate: PaintingCollectionDelegate?
}
