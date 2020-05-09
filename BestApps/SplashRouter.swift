//
//  SplashRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class SplashRouter: SplashRouterProtocol {
    weak var viewController: UIViewController!
    
    static func buildModule() -> SplashViewController {
        let ref = SplashViewController.instantiate(from: .mainMenu)
        let presenter: SplashPresenter & SplashInteractorOutput = SplashPresenter()
        
        let interactor = SplashInteractor()
        interactor.presenter = presenter
        
        let router = SplashRouter()
        router.viewController = ref
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        
        return ref
    }
    
    func goToCategoryList(for device: Device) {
        let vc = CategoryListRouter.buildModule(for: device)
        let navController = viewController.navigationController
        navController?.pushViewController(vc, animated: true)
    }
    
    func routeToError(with message: String) {
        let mAlert = UIAlertController(title: "General.Alert.Error.Title".localized, message: message, preferredStyle: .alert)
        mAlert.addAction(UIAlertAction(title: "General.Alert.OK".localized,
                                       style: .default,
                                       handler: { [weak self] (alert: UIAlertAction!) in
            self?.goToCategoryList(for: UIDevice.current.userInterfaceIdiom == .pad ? .ipad : .iphone)
        }))
        viewController.present(mAlert, animated: true, completion: nil)
    }
}
