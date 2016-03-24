//
//  PaintingListViewController.swift
//  Painting
//
//  Created by Jordan Davis on 2/20/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

class PaintingListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PaintingCollectionDelegate , PaintViewControllerDelegate {
    
    //DATA
    var _paintGallery: PaintGallery?
    
    //cast view as UICollectionView
    var paintingCollectionView: UICollectionView {
        return view as! UICollectionView
    }

    // MARK: - UIViewController Overrides
    override func loadView() {
    }

    override func viewDidLoad() {
        
        //create gallery
        _paintGallery = PaintGallery()
        
        //Add '+' button to navBar
        let newButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addNewPainting:")
        navigationItem.rightBarButtonItem = newButton
        self.navigationController?.navigationBar.barStyle = UIBarStyle.BlackOpaque
        let paintingCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 1, green: 153/255, blue: 75/255, alpha: 1)]
        
        //set cell item size.
        paintingCollectionViewLayout.itemSize.width = 128
        paintingCollectionViewLayout.itemSize.height = 227
        
        //set view
        view = UICollectionView(frame: CGRectZero, collectionViewLayout: paintingCollectionViewLayout)
        paintingCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        paintingCollectionView.backgroundColor = UIColor.lightGrayColor()
        paintingCollectionView.dataSource = self
        paintingCollectionView.delegate = self
        _paintGallery!.delegate = self
        self.paintingCollectionView.reloadData()
    }
    
    // MARK: - UIViewControllerDelegate Methods
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the data model
        return _paintGallery!.paintingCount
    }
    
    //populates each cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let dataItem: Painting = (_paintGallery?.paintingAtIndex(indexPath.item))!
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(UICollectionViewCell.self), forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        
        //SET CELL PREVIEW
        let cellView: UIImageView = UIImageView(image: dataItem.paintingImage)
        cellView.frame = cell.bounds
        cell.contentView.addSubview(cellView)
        return cell;
    }
    
    //selects the cell
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let paintingViewController: PaintingViewController = PaintingViewController()
        paintingViewController.title = "Canvas"
        paintingViewController.paintingIndex = indexPath.item
        paintingViewController.paintingImage = _paintGallery?.getpaintingImageAtIndex(indexPath.item)
        paintingViewController.pvcDelegate = self
        navigationController?.pushViewController(paintingViewController, animated: true)
    }

    //manages layout of cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 25, bottom: 20, right: 25)
    }
    
    
    // MARK: - Add new painting to collection
    func addNewPainting(sender: UIBarButtonItem) {
        self._paintGallery!.addPainting(Painting())
        let paintingViewController: PaintingViewController = PaintingViewController()
        paintingViewController.title = "Canvas"
        paintingViewController.paintingIndex = (_paintGallery?.paintingCount)! - 1
        paintingViewController.paintingImage = _paintGallery?.getpaintingImageAtIndex((_paintGallery?.paintingCount)! - 1)
        paintingViewController.pvcDelegate = self
        navigationController?.pushViewController(paintingViewController, animated: true)
        self.paintingCollectionView.reloadData()
    }

    // MARK: - VC DELEGATE METHODS
    //update cell preview image
    func updateImage(paintView: PaintView, updateImage image: UIImage, index: Int){
        self._paintGallery?.setPaintingImageToIndex(image, index: index)
        self.paintingCollectionView.reloadData()
    }
    
    //delete the painting from collection
    func deletePaintingDelegate(index: Int) {
        self._paintGallery?.removePainting(index)
        self.paintingCollectionView.reloadData()
    }
    
    //MARK: - DATA MEMBER DELEGATE
    func collection(collection: PaintGallery, paintingChanged paintingIndex: Int){
        paintingCollectionView.reloadData()
    }

}
