//
//  SplashRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class SplashRouter: SplashRouterProtocol {
    var viewController: UIViewController!
    
    func goToCategoryList() {
        let vc = ModuleBuilder.buildCategoryModule()
        let homeVC = UINavigationController(rootViewController: vc)
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.navigationBar.backItem?.hidesBackButton = true
        homeVC.navigationBar.prefersLargeTitles = true
        UIApplication.shared.rootModuleView = homeVC
    }
    
    func routeToError(with message: String) {
        let mAlert = UIAlertController(title: "General.Alert.Error.Title".localized, message: message, preferredStyle: .alert)
        mAlert.addAction(UIAlertAction(title: "General.Alert.OK".localized,
                                       style: .default,
                                       handler: { [weak self] (alert: UIAlertAction) in
            self?.goToCategoryList()
        }))
        viewController.present(mAlert, animated: true, completion: nil)
    }
}
