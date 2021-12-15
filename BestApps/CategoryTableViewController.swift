//
//  CategoryTableViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

final class CategoryTableViewController: BaseViewController, CategoryListView {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: VARIABLES
    var presenter: CategoryListPresenterProtocol!
    private let transition = PopUpAnimation()
    private var selectedRow: IndexPath?
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationItem.title = "General.NavBar.Title".localized
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CategoryTableViewCell.self))
        tableView.alpha = .zero
        transition.animationDelegate = self
        UIView.animate(withDuration: 0.75) { [weak self] in
            self?.tableView.alpha = 1.0
        }
    }
}

// MARK: TABLEVIEW METHODS
extension CategoryTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let mView = UIView()
        mView.backgroundColor = UIColor.clear
        return mView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getCategoryCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCategory = presenter.getCategory(at: indexPath.section)
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryTableViewCell.self)) as! CategoryTableViewCell
        cell.configure(with: cellCategory)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
        transition.snapshot = tableView.cellForRow(at: indexPath)?.takeScreenshot()
        self.presenter.didSelectItem(at: indexPath.section)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = self.tableView.contentOffset.y
        for cell in self.tableView.visibleCells as! [CategoryTableViewCell] {
            let x = cell.categoryImage.frame.origin.x
            let w = cell.categoryImage.bounds.width
            let h = cell.categoryImage.bounds.height
            let y = ((offsetY - cell.frame.origin.y) / h) * 25
            cell.categoryImage.frame = CGRect(x: x, y: y, width: w, height: h)
        }
    }
}

// MARK: TRANSITION DELEGATE METHODS
extension CategoryTableViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPathCell = selectedRow,
              let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? CategoryTableViewCell,
              let selectedCellSuperview = selectedCell.superview
        else {
            return nil
        }
        
        transition.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        transition.originFrame = CGRect(
            x: transition.originFrame.origin.x,
            y: transition.originFrame.origin.y,
            width: transition.originFrame.size.width,
            height: transition.originFrame.size.height
        )
        
        transition.presenting = true
        selectedCell.contentView.isHidden = true
        return transition
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}

// MARK: ANIMATION DELEGATE (COMPLETION)
extension CategoryTableViewController: AnimationCompletionDelegate {
    func dismissCompleted() {
        guard let selectedIndexPathCell = selectedRow, let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? CategoryTableViewCell
        else {
            return
        }
        
        selectedCell.contentView.isHidden = false
        selectedRow = nil
    }
}
