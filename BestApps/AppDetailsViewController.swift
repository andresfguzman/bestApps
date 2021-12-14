//
//  AppDetailsViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 11/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

final class AppDetailsViewController: BaseViewController, AppDetailsView {

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
        firstPhoto.load(from: model.app_image2 ?? .empty)
        appDescription.text = model.app_summary
        buttonUrl.setTitle("AppDetails.linkURL".localized, for: .normal)
        
        if Double(model.app_price ?? .empty) == .zero {
            appPrice.text = String(format: "AppDetails.price".localized, "AppDetails.freeApp".localized)
        } else {
            appPrice.text = String(format: "AppDetails.price".localized, model.app_price ?? .empty)
        }
    }
    
    @IBAction func openUrl(sender: AnyObject) {
        presenter.didTapOpenUrl()
    }
}
