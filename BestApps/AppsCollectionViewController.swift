//
//  AppsCollectionViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit
import KFSwiftImageLoader

private let reuseIdentifier = "Cell"

class AppsCollectionViewController: UICollectionViewController{

  // MARK: VARIABLES
  
  var appsInCategory : [App]?
  var currentIndex = 0
  
  // MARK: OVERRIDE METHODS
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      setupCollectionView()
              // Register cell classes
        self.collectionView!.registerClass(AppCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

  
  // Método para configurar el Collection view con las margenes y tamaños deseados, actualmente se acomoda al tamaño de la pantalla.
  
  func setupCollectionView(){
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let mWidth = ((screenSize.width)/5)
    let mHeigth = mWidth
    let overallSpacing = mWidth/3
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: overallSpacing, left: overallSpacing, bottom: overallSpacing, right: overallSpacing)
    layout.itemSize = CGSize(width: mWidth, height: mHeigth)
    collectionView!.collectionViewLayout = layout

  }
  
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (appsInCategory?.count)!
    }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    currentIndex = indexPath.item
    performSegueWithIdentifier("goToDetails", sender: nil)
  }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
      let appAtIndex = appsInCategory![indexPath.item]
      
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AppCollectionViewCell
      cell.imageView.loadImageFromURLString(appAtIndex.app_image1!)
      cell.textLabel.text = appAtIndex.app_name
        return cell
    }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "goToDetails"{
      
      let targetVC = segue.destinationViewController.childViewControllers[0] as! AppDetailsViewController
      targetVC.currentApp = appsInCategory![currentIndex]
      
    }
    
  }
  
}
