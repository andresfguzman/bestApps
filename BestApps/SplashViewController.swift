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
  @IBOutlet weak var visualEffectView: UIVisualEffectView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBarHidden = true
      let helperMethod = GlobalClass.Instance
      helperMethod.obtainMainService(helperMethod.mainServiceURL,currentController: self)
      setupLoadingView() 
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func setupLoadingView(){
    visualEffectView.layer.cornerRadius = 10
    visualEffectView.clipsToBounds = true
    activityIndicator.startAnimating()

  }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
      if segue.identifier == "goToMenu"{
        
        let targetVC = segue.destinationViewController as! CategoryTableViewController
        targetVC.appCategories = (DBHelper.Instance.managedObjectsByName("Category") as! [Category])
      }
      
    }

}
