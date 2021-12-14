//
//  CategoryListRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class CategoryListRouter: CategoryListRouterProtocol {
    var viewController: UIViewController!
    
    func goToAppList(with category: Category) {
        let vc = ModuleBuilder.buildAppListModule(with: category)
        let navController = UINavigationController(rootViewController: vc)
        navController.transitioningDelegate = (viewController as? UIViewControllerTransitioningDelegate)
        navController.modalPresentationStyle = .fullScreen
        viewController.present(navController, animated: true, completion: nil)
    }
}
