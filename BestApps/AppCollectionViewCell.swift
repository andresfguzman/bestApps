//
//  AppCollectionViewCell.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

final class AppCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override var reuseIdentifier: String? {
        String(describing: AppCollectionViewCell.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleToFill
        contentView.addSubview(imageView)
        contentView.backgroundColor = nil
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
        
        let pintop = NSLayoutConstraint(item: imageView!, attribute: .top, relatedBy: .equal,
                                        toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: imageView!, attribute: .trailing, relatedBy: .equal,
                                         toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: imageView!, attribute: .leading, relatedBy: .equal,
                                          toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0)
        let pinBot = NSLayoutConstraint(item: imageView!, attribute: .bottom, relatedBy: .equal,
                                        toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([pintop, pinBot, pinLeft, pinRight])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
