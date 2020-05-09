//
//  AppListPresenter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

final class AppListPresenter: AppListPresenterProtocol {
    weak var view: AppListView!
    var category: Category!
    var apps: [App] = []
    var interactor: AppListInteractorProtocol!
    var router: AppListRouterProtocol!
    
    init(category: Category) {
        self.category = category
    }
    
    func viewDidLoad() {
        interactor.getApps(for: category)
    }
    
    func didSelectItem(at index: Int) {
        router.goToAppDetails(with: apps[index])
    }
    
    func getAppsCount() -> Int {
        return apps.count
    }
    
    func getApp(at index: Int) -> App {
        return apps[index]
    }
}

extension AppListPresenter: AppListInteractorOutput {
    func getAppsSucceeds(with apps: [App]) {
        self.apps = apps
    }
    
    func getAppsFails(with error: Error) {
        router.routeToError(with: error.localizedDescription)
    }
}
