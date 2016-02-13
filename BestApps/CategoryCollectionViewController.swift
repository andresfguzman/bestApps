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
  
  // MARK: OVERRIDE METHODS
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBarHidden = false
      self.title = "Best Apps Ever!"
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
    layout.minimumLineSpacing = overallSpacing/2
    layout.itemSize = CGSize(width: mWidth, height: mHeigth)
    collectionView!.collectionViewLayout = layout

  }
  
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (categoriesRetrived?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cellCategory = categoriesRetrived![indexPath.item]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AppCollectionViewCell
      cell.imageView.image = UIImage(named: cellCategory.cat_name!)
      cell.textLabel.text = cellCategory.cat_name
        return cell
    }

  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let selectedCell = collectionView.cellForItemAtIndexPath(indexPath)
    // se actualiza la variable global currentIndex para indicar la posición a la que se dió click y poder recuperar los datos dependiendo del id de la misma, esta consulta se realiza en el prepare for segue.
    selectedCell?.superview?.bringSubviewToFront(selectedCell!)
    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [UIViewAnimationOptions.CurveEaseOut], animations: { () -> Void in
      selectedCell?.frame = collectionView.bounds
      collectionView.scrollEnabled = false
      }, completion: {(completion) -> Void in
      
        self.currentIndex = indexPath.item
        self.performSegueWithIdentifier("goToApps", sender: nil)
        
      })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "goToApps"{
      let targetVC = segue.destinationViewController as! AppsCollectionViewController
      targetVC.appsInCategory = (DBHelper.Instance.managedObjectsByName("App",hasPredicate: true,predicateFormat: "%K == %@",predicateFilterParameter: "cat_id",predicateData: categoriesRetrived![currentIndex].cat_id!) as! [App])
      
    }
  }

  override func viewWillDisappear(animated: Bool) {
    let allIndexPaths = collectionView!.indexPathsForSelectedItems()! as [NSIndexPath]
    collectionView!.scrollEnabled = true
    collectionView!.reloadItemsAtIndexPaths(allIndexPaths)
  }
  
}
