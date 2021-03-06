//
//  AppDetailsViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 11/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class AppDetailsViewController: BaseViewController, AppDetailsView {

    var presenter: AppDetailsPresenterProtocol!
    
    @IBOutlet weak var firstPhoto: UIImageView!
    @IBOutlet weak var appDescription: UILabel!
    @IBOutlet weak var buttonUrl: UIButton!
    @IBOutlet weak var appPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    func setupView(with model: App) {
        self.title = model.app_name
        firstPhoto.load(from: model.app_image2 ?? "")
        appDescription.text = model.app_summary
        buttonUrl.setTitle("AppDetails.linkURL".localized, for: .normal)
        if model.app_price == "0.00000"{
            appPrice.text = String(format: "AppDetails.price".localized, "Gratuita")
        } else {
            appPrice.text = String(format: "AppDetails.price".localized, model.app_price!)
        }
    }
    
    @IBAction func openUrl(sender: AnyObject) {
        presenter.didTapOpenUrl()
    }
}
