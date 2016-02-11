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

  var appsInCategory : [App]?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      let screenSize: CGRect = UIScreen.mainScreen().bounds
      let mWidth = ((screenSize.width)/5)
      let mHeigth = mWidth
      let overallSpacing = mWidth/3
      let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
      layout.sectionInset = UIEdgeInsets(top: overallSpacing, left: overallSpacing, bottom: overallSpacing, right: overallSpacing)
      layout.itemSize = CGSize(width: mWidth, height: mHeigth)
      collectionView!.collectionViewLayout = layout
        // Register cell classes
        self.collectionView!.registerClass(AppCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (appsInCategory?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
      let appAtIndex = appsInCategory![indexPath.item]
      
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AppCollectionViewCell
        // Configure the cell
      cell.imageView.loadImageFromURLString(appAtIndex.app_image1!)
      cell.textLabel.text = appAtIndex.app_name
        return cell
    }

}
