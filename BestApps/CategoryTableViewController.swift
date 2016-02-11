//
//  CategoryTableViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

  var appCategories : [Category]?
  var currentIndex = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBarHidden = false
    }

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
        // #warning Incomplete implementation, return the number of sections
        return (appCategories?.count)!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as! CategoryTableViewCell
      cell.categoryName.text = appCategories![indexPath.section].cat_name

        // Configure the cell...

        return cell
    }

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    currentIndex = indexPath.section
    performSegueWithIdentifier("goToApps", sender: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "goToApps"{
      let targetVC = segue.destinationViewController as! AppsCollectionViewController
      targetVC.appsInCategory = (DBHelper.Instance.managedObjectsByName("App",hasPredicate: true,predicateFormat: "%K == %@",predicateFilterParameter: "cat_id",predicateData: appCategories![currentIndex].cat_id!) as! [App])
      
    }
  }

}
