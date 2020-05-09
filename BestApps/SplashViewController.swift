//
//  SplashViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController, SplashView {
    
    var presenter: SplashPresenterProtocol!
    
    // MARK: UI Elements
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        presenter.viewDidLoad()
    }
    
    func showLoadingView() {
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView() {
        activityIndicator.stopAnimating()
    }
}
