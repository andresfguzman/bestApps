//
//  ModuleBuilder.swift
//  BestApps
//
//  Created by Andrés Guzmán on 14/12/21.
//  Copyright © 2021 andres. All rights reserved.
//

import Foundation
import UIKit

final class ModuleBuilder {
    static func buildSplash() -> UIViewController {
        let ref = SplashViewController.instantiate(from: .mainMenu)
        let presenter: SplashPresenter & SplashInteractorOutput = SplashPresenter()
        
        let interactor = SplashInteractor(service: FeedServiceAdapter())
        interactor.presenter = presenter
        
        let router = SplashRouter()
        router.viewController = ref
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        
        return ref
    }
    
    static func buildCategoryModule() -> UIViewController {
        let ref = CategoryTableViewController.instantiate(from: .mainMenu)

        let presenter: CategoryListPresenterProtocol & CategoryListInteractorOutput = CategoryListPresenter()
        
        let interactor = CategoryListInteractor()
        interactor.presenter = presenter
        
        let router = CategoryListRouter()
        router.viewController = ref
        
        presenter.view = ref as CategoryListView
        presenter.interactor = interactor
        presenter.router = router
        
        (ref as CategoryListView).presenter = presenter
        
        return ref
    }
    
    static func buildAppListModule(with category: Category) -> UIViewController {
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
    
    static func buildAppDetailsModule(with model: App) -> UIViewController {
        let ref = AppDetailsViewController.instantiate(from: .appDetails)
        let presenter: AppDetailsPresenterProtocol & AppDetailsInteractorOutput = AppDetailsPresenter(appModel: model)
        
        let router = AppDetailsRouter()
        router.viewController = ref
        
        presenter.view = ref
        presenter.router = router
        
        ref.presenter = presenter
        
        return ref
    }
}
