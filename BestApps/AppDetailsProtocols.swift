//
//  AppDetailsProtocols.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

protocol AppDetailsView: AnyObject {
    var presenter: AppDetailsPresenterProtocol! { get set }
    func setupView(with model: App)
}

protocol AppDetailsPresenterProtocol: AnyObject {
    var view: AppDetailsView! { get set }
    var appModel: App! { get set }
    func viewDidLoad()
    func didTapOpenUrl()
}

protocol AppDetailsInteractorOutput: AnyObject {
    var router: AppDetailsRouterProtocol! { get set }
}

protocol AppDetailsRouterProtocol: AnyObject {
    var viewController: UIViewController! { get set }
    func openUrl(with link: URL)
}
