//
//  SplashPresenter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class SplashPresenter: SplashPresenterProtocol {
    weak var view: SplashView!
    var router: SplashRouterProtocol!
    var interactor: SplashInteractorProtocol!
    
    func viewDidLoad() {
        interactor.getData()
    }
}

extension SplashPresenter: SplashInteractorOutput {
    
    func getDataSucceeds() {
        router.goToCategoryList(for: UIDevice.current.userInterfaceIdiom == .pad ? .ipad : .iphone)
    }
    
    func getDataFails(with error: Error) {
        router.routeToError(with: error.localizedDescription)
    }
}
