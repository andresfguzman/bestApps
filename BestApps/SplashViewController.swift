//
//  SplashViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: BaseViewController, SplashView {
    weak private var loaderView: AnimationView!
    var presenter: SplashPresenterProtocol!
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let loaderView = AnimationView(name: "Splash")
        
        loaderView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        loaderView.center = self.view.center
        loaderView.contentMode = .scaleAspectFill
        loaderView.loopMode = .playOnce
        
        view.addSubview(loaderView)
        
        loaderView.play { [weak self] (_) in
            self?.presenter.viewDidLoad()
        }
    }
}
