//
//  AppDetailsRouter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

final class AppDetailsRouter: AppDetailsRouterProtocol {
    var viewController: UIViewController!
    
    func openUrl(with link: URL) {
        UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }
}
