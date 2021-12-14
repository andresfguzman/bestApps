//
//  AppListRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class AppListRouter: AppListRouterProtocol {
    var viewController: UIViewController!
    
    func goToAppDetails(with model: App) {
        let vc = ModuleBuilder.buildAppDetailsModule(with: model)
        let navController = viewController.navigationController
        navController?.pushViewController(vc, animated: true)
    }
    
    func routeToError(with message: String) {
        // TODO: Manage error in future iterations
    }
}
