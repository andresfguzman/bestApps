//
//  CategoryListProtocols.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

protocol CategoryListView: AnyObject {
    var presenter: CategoryListPresenterProtocol! { get set }
}

protocol CategoryListPresenterProtocol: AnyObject {
    var view: CategoryListView! { get set }
    var interactor: CategoryListInteractorProtocol! { get set }
    func viewDidLoad()
    func didSelectItem(at index: Int)
    func getCategoryCount() -> Int
    func getCategory(at index: Int) -> Category
}

protocol CategoryListInteractorProtocol: AnyObject {
    var presenter: CategoryListInteractorOutput! { get set }
    func getCategories()
}

protocol CategoryListInteractorOutput: AnyObject {
    var router: CategoryListRouterProtocol! { get set }
    func getCategoriesSucceed(with categories: [Category])
    func getCategoriesFailed()
}

protocol CategoryListRouterProtocol: AnyObject {
    var viewController: UIViewController! { get set }
    func goToAppList(with category: Category)
}
