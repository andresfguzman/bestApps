//
//  AppsCollectionViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppsCollectionViewController: UICollectionViewController, AppListView {
    
    // MARK: VARIABLES
    var presenter: AppListPresenterProtocol!
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        presenter.viewDidLoad()
        // Register cell classes
        self.collectionView!.register(AppCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    // Método para configurar el Collection view con las margenes y tamaños deseados, actualmente se acomoda al tamaño de la pantalla.
    
    func setupCollectionView(){
        let screenSize: CGRect = UIScreen.main.bounds
        let mWidth = ((screenSize.width)/5)
        let mHeigth = mWidth
        let overallSpacing = mWidth/3
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: overallSpacing, left: overallSpacing, bottom: overallSpacing, right: overallSpacing)
        layout.itemSize = CGSize(width: mWidth, height: mHeigth)
        layout.minimumLineSpacing = overallSpacing/2
        collectionView!.collectionViewLayout = layout
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getAppsCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelectItem(at: indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let appAtIndex = presenter.getApp(at: indexPath.item)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppCollectionViewCell
        cell.imageView.load(from: appAtIndex.app_image2 ?? "")
        cell.textLabel.text = appAtIndex.app_name
        return cell
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        let allIndexPaths = self.collectionView!.indexPathsForSelectedItems! as [NSIndexPath]
        collectionView!.isScrollEnabled = true
        collectionView!.reloadItems(at: allIndexPaths as [IndexPath])
    }
}

extension AppsCollectionViewController: Storyboard { }
