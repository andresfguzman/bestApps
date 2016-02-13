//
//  AppDetailsViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 11/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class AppDetailsViewController: UIViewController {

  var currentApp : App!
  
  @IBOutlet weak var firstPhoto: UIImageView!
  @IBOutlet weak var secondPhoto: UIImageView!
  @IBOutlet weak var thirdPhoto: UIImageView!
  @IBOutlet weak var appDescription: UILabel!
  @IBOutlet weak var buttonUrl: UIButton!
  @IBOutlet weak var appPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      setupProfileContent()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func setupProfileContent(){
    
    self.title = currentApp.app_name
    firstPhoto.loadImageFromURLString(currentApp.app_image1!)
    secondPhoto.loadImageFromURLString(currentApp.app_image2!)
    thirdPhoto.loadImageFromURLString(currentApp.app_image3!)
    appDescription.text = currentApp.app_summary
    buttonUrl.setTitle(currentApp.app_link, forState: .Normal)
    if currentApp.app_price == "0.00000"{
      appPrice.text = "Precio: Gratuita"
    } else {
      appPrice.text = "Precio: \(currentApp.app_price)"
    }
  }

  
  @IBAction func closeController(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
  }
  
  @IBAction func openUrl(sender: AnyObject) {
    let linkString = currentApp.app_link!
    print(linkString)
    UIApplication.sharedApplication().openURL(NSURL(string: linkString)!)
    
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
