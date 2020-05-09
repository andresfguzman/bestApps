//
//  AppListProtocols.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

protocol AppListView: AnyObject {
    var presenter: AppListPresenterProtocol! { get set }
}

protocol AppListPresenterProtocol: AnyObject {
    var view: AppListView! { get set }
    var category: Category! { get set }
    var interactor: AppListInteractorProtocol! { get set }
    func viewDidLoad()
    func didSelectItem(at index: Int)
    func getAppsCount() -> Int
    func getApp(at index: Int) -> App
}

protocol AppListInteractorProtocol: AnyObject {
    var presenter: AppListInteractorOutput! { get set }
    func getApps(for category: Category)
}

protocol AppListInteractorOutput: AnyObject {
    var router: AppListRouterProtocol! { get set }
    func getAppsSucceeds(with apps: [App])
    func getAppsFails(with error: Error)
}

protocol AppListRouterProtocol: AnyObject {
    var viewController: UIViewController! { get set }
    func goToAppDetails(with model: App)
    func routeToError(with message: String)
}
