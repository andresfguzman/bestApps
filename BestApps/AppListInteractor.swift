//
//  AppListInteractor.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

final class AppListInteractor: AppListInteractorProtocol {
    weak var presenter: AppListInteractorOutput!
    
    func getApps(for category: Category) {
        guard let apps = (DBHelper.Instance.managedObjectsByName(entityName: "App",
                                                                 hasPredicate: true,
                                                                 predicateFormat: "%K == %@",
                                                                 predicateFilterParameter: "cat_id",
                                                                 predicateData: category.cat_id!) as? [App]) else {
                                                                    presenter.getAppsFails(with: NSError(domain: "DB", code: -999, userInfo: nil))
                                                                    return
        }
        
        presenter.getAppsSucceeds(with: apps)
    }
}
