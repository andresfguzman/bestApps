//
//  SplashProtocols.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

protocol SplashView: AnyObject {
    var presenter: SplashPresenterProtocol! { get set }
    func showLoadingView()
    func hideLoadingView()
}

protocol SplashPresenterProtocol: AnyObject {
    var view: SplashView! { get set }
    var interactor: SplashInteractorProtocol! { get set }
    func viewDidLoad()
}

protocol SplashInteractorProtocol: AnyObject {
    var presenter: SplashInteractorOutput! { get set }
    func getData()
}

protocol SplashInteractorOutput: AnyObject {
    var router: SplashRouterProtocol! { get set }
    func getDataSucceeds()
    func getDataFails(with error: Error)
}

protocol SplashRouterProtocol: AnyObject {
    var viewController: UIViewController! { get set }
    func goToCategoryList(for device: Device)
    func routeToError(with message: String)
}