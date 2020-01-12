//
//  AppsCollectionViewController.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit
import KFSwiftImageLoader

private let reuseIdentifier = "Cell"

class AppsCollectionViewController: UICollectionViewController{
    
    // MARK: VARIABLES
    
    var appsInCategory : [App]?
    var currentIndex = 0
    
    // MARK: OVERRIDE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
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
        return (appsInCategory?.count)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let toanimate = collectionView.cellForItemAtIndexPath(indexPath) as! AppCollectionViewCell
        
        let selectedCell = collectionView.cellForItem(at: indexPath)
        // se actualiza la variable global currentIndex para indicar la posición a la que se dió click y poder recuperar los datos dependiendo del id de la misma, esta consulta se realiza en el prepare for segue.
        selectedCell?.superview?.bringSubviewToFront(selectedCell!)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { () -> Void in
            
            selectedCell?.frame = collectionView.bounds
            collectionView.isScrollEnabled = false
            
        }, completion: {(completion) -> Void in
            self.currentIndex = indexPath.item
            self.performSegue(withIdentifier: "goToDetails", sender: nil)
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let appAtIndex = appsInCategory![indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppCollectionViewCell
        cell.imageView.loadImage(urlString: appAtIndex.app_image1!)
        cell.textLabel.text = appAtIndex.app_name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails"{
            
            let targetVC = segue.destination.children[0] as! AppDetailsViewController
            targetVC.currentApp = appsInCategory![currentIndex]
        }
    }
    
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        
        let allIndexPaths = self.collectionView!.indexPathsForSelectedItems! as [NSIndexPath]
        collectionView!.isScrollEnabled = true
        collectionView!.reloadItems(at: allIndexPaths as [IndexPath])
    }
}
