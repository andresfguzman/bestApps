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
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        cell.categoryName.text = cellCategory.cat_name//appCategories![indexPath.section].cat_name
        cell.categoryImage.image = UIImage(named: cellCategory.cat_name!)
        cell.categoryCellContent.layer.cornerRadius = 10
        cell.categoryCellContent.clipsToBounds = true
        cell.categoryCellContent.layer.borderWidth = 1.0
        cell.categoryCellContent.layer.borderColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.6).cgColor
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //CellAnimator.animateCell(cell, withTransform: CellAnimator.TransformWave, andDuration: 0.5)
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
