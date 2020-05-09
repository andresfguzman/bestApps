//
//  CategoryCollectionViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

private let reuseIdentifier = "categoryCell"

class CategoryCollectionViewController: UICollectionViewController, CategoryListView {

    // MARK: Variables
    var presenter: CategoryListPresenterProtocol!
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.title = "General.NavBar.Title".localized
        setupCollectionView()
        // Register cell classes
        self.collectionView!.register(AppCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    // Método para agregar margenes y especificaciones adicionales al collection view.
    
    func setupCollectionView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let mWidth = ((screenSize.width)/5)
        let mHeigth = mWidth
        let overallSpacing = mWidth/3
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: overallSpacing, left: overallSpacing, bottom: overallSpacing, right: overallSpacing)
        layout.minimumLineSpacing = overallSpacing/2
        layout.itemSize = CGSize(width: mWidth, height: mHeigth)
        collectionView!.collectionViewLayout = layout
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCategoryCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellCategory = presenter.getCategory(at: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppCollectionViewCell
        cell.imageView.image = UIImage(named: cellCategory.cat_name!)
        cell.textLabel.text = cellCategory.cat_name
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        selectedCell?.superview?.bringSubviewToFront(selectedCell!)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [UIView.AnimationOptions.curveEaseOut], animations: { () -> Void in
            selectedCell?.frame = collectionView.bounds
            collectionView.isScrollEnabled = false
        }, completion: {(completion) -> Void in
            self.presenter.didSelectItem(at: indexPath.item)
            
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let allIndexPaths = collectionView!.indexPathsForSelectedItems! as [IndexPath]
        collectionView!.isScrollEnabled = true
        collectionView!.reloadItems(at: allIndexPaths)
    }
}

extension CategoryCollectionViewController: Storyboard { }
