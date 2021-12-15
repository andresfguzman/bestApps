//
//  AppsCollectionViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class RadialAnimatedViewController: BaseViewController, CircleTransitionable {
    var triggerView: UIView = UIView()
    var cosmeticView: UIView = UIView()
    var mainView: UIView { view }
}

final class AppsCollectionViewController: RadialAnimatedViewController, AppListView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    override var cosmeticView: UIView {
        get {
            return collectionView
        }
        set {
            // DO NOTHING
        }
    }
    
    // MARK: VARIABLES
    var presenter: AppListPresenterProtocol!
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissVC))
        navigationItem.title = presenter.category.cat_name
        setupCollectionView()
        presenter.viewDidLoad()
        headerImageView.image = UIImage(named: presenter.category.cat_name ?? .empty)?.shrink(to: CGSize(width: 480, height: 480))
        headerImageView.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        // Register cell classes
        self.collectionView!.register(AppCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AppCollectionViewCell.self))
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        let allIndexPaths = self.collectionView!.indexPathsForSelectedItems! as [NSIndexPath]
        collectionView!.isScrollEnabled = true
        collectionView!.reloadItems(at: allIndexPaths as [IndexPath])
    }
}

// MARK: COLLECTION DELEGATE METHODS
extension AppsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getAppsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        triggerView = collectionView.cellForItem(at: indexPath) ?? UIView()
        self.presenter.didSelectItem(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let appAtIndex = presenter.getApp(at: indexPath.item)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AppCollectionViewCell.self), for: indexPath) as! AppCollectionViewCell
        cell.imageView.load(from: appAtIndex.app_image2 ?? .empty)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: .zero, y: .zero)
        UIView.animate(withDuration: 0.20, delay: 0.1, options: .curveEaseIn) {
            cell.transform = .identity
        }
    }
}
