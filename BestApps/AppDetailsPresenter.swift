//
//  AppDetailsPresenter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

final class AppDetailsPresenter: AppDetailsPresenterProtocol {
    var view: AppDetailsView!
    var appModel: App!
    var router: AppDetailsRouterProtocol!
    
    init(appModel: App) {
        self.appModel = appModel
    }
    
    func viewDidLoad() {
        view.setupView(with: appModel)
    }
    
    func didTapOpenUrl() {
        // TODO: manage force unwrapping.
        router.openUrl(with: URL(string: appModel.app_link!)!)
    }
}

extension AppDetailsPresenter: AppDetailsInteractorOutput {
    
}
