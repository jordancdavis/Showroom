//
//  AppDelegate.swift
//  Painting
//
//  Created by Jordan Davis on 2/20/16.
//  Copyright © 2016 cs4962. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var _paintGallery: PaintGallery = PaintGallery()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let paintingRootListViewController: PaintingListViewController = PaintingListViewController()
        paintingRootListViewController.title = "Gallery"
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let navController = UINavigationController(rootViewController: paintingRootListViewController)
        navController.navigationBar.translucent = false
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
        
    }

}
