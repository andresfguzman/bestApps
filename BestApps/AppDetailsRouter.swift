//
//  AppDetailsRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class AppDetailsRouter: AppDetailsRouterProtocol {
    var viewController: UIViewController!
    
    static func buildModule(with model: App) -> AppDetailsViewController {
        let ref = AppDetailsViewController.instantiate(from: .appDetails)
        let presenter: AppDetailsPresenterProtocol & AppDetailsInteractorOutput = AppDetailsPresenter(appModel: model)
        
        let router = AppDetailsRouter()
        router.viewController = ref
        
        presenter.view = ref
        presenter.router = router
        
        ref.presenter = presenter
        
        return ref
    }
    
    func openUrl(with link: URL) {
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }
}
