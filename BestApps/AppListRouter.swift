//
//  AppListRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class AppListRouter: AppListRouterProtocol {
    weak var viewController: UIViewController!
    
    static func buildModule(with category: Category) -> AppsCollectionViewController {
        let ref = AppsCollectionViewController.instantiate(from: .appList)
        let presenter: AppListPresenterProtocol & AppListInteractorOutput = AppListPresenter(category: category)
        
        let interactor = AppListInteractor()
        interactor.presenter = presenter
        
        let router = AppListRouter()
        router.viewController = ref
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        
        return ref
    }
    
    func goToAppDetails(with model: App) {
        let vc = AppDetailsRouter.buildModule(with: model)
        let navController = viewController.navigationController
        navController?.pushViewController(vc, animated: true)
    }
    
    func routeToError(with message: String) {
        // go to error
    }
}
