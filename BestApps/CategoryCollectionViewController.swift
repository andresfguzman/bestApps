//
//  CategoryCollectionViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

private let reuseIdentifier = "categoryCell"

class CategoryCollectionViewController: UICollectionViewController {

  
  // MARK: variables
  var categoriesRetrived : [Category]?
  var currentIndex = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBarHidden = false
      setupCollectionView()
        // Register cell classes
        self.collectionView!.registerClass(AppCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

  // Método para agregar margenes y especificaciones adicionales al collection view.
  
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (categoriesRetrived?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cellCategory = categoriesRetrived![indexPath.item]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AppCollectionViewCell
      cell.imageView.image = UIImage(named: "games_category")
      cell.textLabel.text = cellCategory.cat_name
    
        // Configure the cell
    
        return cell
    }

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    currentIndex = indexPath.item
    performSegueWithIdentifier("goToApps", sender: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "goToApps"{
      let targetVC = segue.destinationViewController as! AppsCollectionViewController
      targetVC.appsInCategory = (DBHelper.Instance.managedObjectsByName("App",hasPredicate: true,predicateFormat: "%K == %@",predicateFilterParameter: "cat_id",predicateData: categoriesRetrived![currentIndex].cat_id!) as! [App])
      
    }
  }
}
