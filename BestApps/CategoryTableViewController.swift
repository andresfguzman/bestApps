//
//  CategoryTableViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

  // MARK: VARIABLES
  
  var appCategories : [Category]?
  var currentIndex = 0
  
  // MARK: OVERRIDE METHODS
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBarHidden = false
      self.title = "Best Apps Ever!"
    }

  // MARK: TABLEVIEW SETUP
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 90
  }
  
  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 5
  }
  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let mView = UIView()
    mView.backgroundColor = UIColor.clearColor()
    return mView
  }
  
  
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (appCategories?.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cellCategory = appCategories![indexPath.section]
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as! CategoryTableViewCell
      cell.categoryName.text = cellCategory.cat_name//appCategories![indexPath.section].cat_name
      cell.categoryImage.image = UIImage(named: cellCategory.cat_name!)
      cell.categoryCellContent.layer.cornerRadius = 15
      cell.categoryCellContent.clipsToBounds = true
      cell.categoryCellContent.layer.borderWidth = 3.0
      cell.categoryCellContent.layer.borderColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1).CGColor
        return cell
      
    }
  
  override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    //CellAnimator.animateCell(cell, withTransform: CellAnimator.TransformWave, andDuration: 0.5)
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // Se actualiza la variable global current index para obtener la lista de apps de determinada categoria y enviarla al controlador de destino mediante el metodo prepareforsegue.
    let currentCell = tableView.cellForRowAtIndexPath(indexPath)
    
    UIView.animateWithDuration(0.2, delay: 0.0,
      options: [UIViewAnimationOptions.CurveEaseOut],
      animations: {
        currentCell!.layer.position.x += 100.0
      }, completion: {completion in
        self.currentIndex = indexPath.section
        self.performSegueWithIdentifier("goToApps", sender: nil)
        UIView.animateWithDuration(1.0, delay: 0.0,
          options: [UIViewAnimationOptions.CurveEaseIn],
          animations: {
            currentCell!.layer.position.x -= 100.0
          }, completion: {completion in
        })
        
    })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "goToApps"{
      let targetVC = segue.destinationViewController as! AppsCollectionViewController
      targetVC.appsInCategory = (DBHelper.Instance.managedObjectsByName("App",hasPredicate: true,predicateFormat: "%K == %@",predicateFilterParameter: "cat_id",predicateData: appCategories![currentIndex].cat_id!) as! [App])
      
    }
  }

}
