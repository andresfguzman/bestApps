//
//  CategoryListInteractor.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

final class CategoryListInteractor: CategoryListInteractorProtocol {
    weak var presenter: CategoryListInteractorOutput!
    
    func getCategories() {
        guard let categories = DBHelper.Instance.managedObjectsByName(entityName: "Category") as? [Category] else {
            presenter.getCategoriesFailed()
            return
        }
        presenter.getCategoriesSucceed(with: categories)
    }
}
