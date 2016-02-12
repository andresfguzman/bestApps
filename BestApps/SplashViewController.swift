//
//  SplashViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

  // MARK: UI Elements
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: OVERRIDE METHODS
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBarHidden = true
      let helperMethod = GlobalClass.Instance
      activityIndicator.startAnimating()
      helperMethod.obtainMainService(helperMethod.mainServiceURL,currentController: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      // Se realiza la navegación con la ayuda de segues en el storyboard. Dependiendo de su identificador se ejecutan las acciones pertinentes.
      
      if segue.identifier == "goToMenu"{
        let targetVC = segue.destinationViewController as! CategoryTableViewController
        targetVC.appCategories = (DBHelper.Instance.managedObjectsByName("Category") as! [Category])
      } else if segue.identifier == "goToMenu2"{
        let targetVC = segue.destinationViewController as! CategoryCollectionViewController
        targetVC.categoriesRetrived = (DBHelper.Instance.managedObjectsByName("Category") as! [Category])
      }
      
    }

}
