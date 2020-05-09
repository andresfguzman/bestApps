//
//  CategoryListPresenter.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

final class CategoryListPresenter: CategoryListPresenterProtocol {
    
    weak var view: CategoryListView!
    var interactor: CategoryListInteractorProtocol!
    var router: CategoryListRouterProtocol!
    var categories: [Category] = []
    
    func viewDidLoad() {
        interactor.getCategories()
    }
    
    func didSelectItem(at index: Int) {
        router.goToAppList(with: categories[index])
    }
    
    func getCategoryCount() -> Int {
        return categories.count
    }
    
    func getCategory(at index: Int) -> Category {
        return categories[index]
    }
}

extension CategoryListPresenter: CategoryListInteractorOutput {
    func getCategoriesSucceed(with categories: [Category]) {
        self.categories = categories
    }
    
    func getCategoriesFailed() {
        // handle failure
    }
}
