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
        firstPhoto.loadImage(urlString: currentApp.app_image1!)
        secondPhoto.loadImage(urlString: currentApp.app_image2!)
        thirdPhoto.loadImage(urlString: currentApp.app_image3!)
        appDescription.text = currentApp.app_summary
        buttonUrl.setTitle(currentApp.app_link, for: .normal)
        if currentApp.app_price == "0.00000"{
            appPrice.text = "Precio: Gratuita"
        } else {
            appPrice.text = "Precio: \(currentApp.app_price)"
        }
    }
    
    
    @IBAction func closeController(sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func openUrl(sender: AnyObject) {
        let linkString = currentApp.app_link!
        print(linkString)
        UIApplication.shared.open(URL(string: linkString)!, options: [:], completionHandler: nil)
    }
}
