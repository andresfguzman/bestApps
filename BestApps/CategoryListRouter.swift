//
//  CategoryListRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class CategoryListRouter: CategoryListRouterProtocol {
    weak var viewController: UIViewController!
    
    static func buildModule(for device: Device) -> UIViewController {
        var ref: UIViewController!
        if device == .iphone {
            ref = CategoryTableViewController.instantiate(from: .mainMenu)
        } else {
            ref = CategoryCollectionViewController.instantiate(from: .mainMenu)
        }

        let presenter: CategoryListPresenterProtocol & CategoryListInteractorOutput = CategoryListPresenter()
        
        let interactor = CategoryListInteractor()
        interactor.presenter = presenter
        
        let router = CategoryListRouter()
        router.viewController = ref
        
        presenter.view = ref as? CategoryListView
        presenter.interactor = interactor
        presenter.router = router
        
        (ref as! CategoryListView).presenter = presenter
        
        return ref
    }
    
    func goToAppList(with category: Category) {
        let vc = AppListRouter.buildModule(with: category)
        let navController = viewController.navigationController
        navController?.pushViewController(vc, animated: true)
    }
}
