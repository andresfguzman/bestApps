//
//  CategoryTableViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController, CategoryListView {
    
    // MARK: VARIABLES
    var presenter: CategoryListPresenterProtocol!
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CategoryTableViewCell.self))
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: TABLEVIEW SETUP
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let mView = UIView()
        mView.backgroundColor = UIColor.clear
        return mView
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getCategoryCount()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCategory = presenter.getCategory(at: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryTableViewCell.self)) as! CategoryTableViewCell
        cell.configure(with: cellCategory)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        
        UIView.animate(withDuration: 0.2, delay: 0.0,
                       options: [UIView.AnimationOptions.curveEaseOut],
                       animations: {
                        currentCell!.layer.position.x += 100.0
        }, completion: {completion in
            self.presenter.didSelectItem(at: indexPath.section)
            UIView.animate(withDuration: 1.0, delay: 0.0,
                           options: [UIView.AnimationOptions.curveEaseIn],
                           animations: {
                            currentCell!.layer.position.x -= 100.0
            }, completion: {completion in
            })
            
        })
    }
}

extension CategoryTableViewController: Storyboard { }
