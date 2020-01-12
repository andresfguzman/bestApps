//
//  AppCollectionViewCell.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {
    
    
    var textLabel: UILabel!
    //var imageButton : UIButton!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        //imageButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*8/10))
        imageView = UIImageView()
        //imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*8/10))
        //imageButton.contentMode = UIViewContentMode.ScaleToFill
        imageView.clipsToBounds = true
        imageView.contentMode = UIView.ContentMode.scaleToFill
        contentView.addSubview(imageView)
        
        textLabel = UILabel()
        //textLabel = UILabel(frame: CGRect(x: 1, y: imageView.frame.size.height, width: frame.size.width-2, height: frame.size.height*2/10-2))
        //textLabel.font = UIFont.systemFontOfSize(UIFont.buttonFontSize())
        textLabel.font = UIFont.boldSystemFont(ofSize: UIFont.buttonFontSize)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.magenta
        textLabel.backgroundColor = UIColor.clear
        contentView.backgroundColor = nil
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        //contentView.layer.borderWidth = 2.0
        //contentView.layer.borderColor = UIColor.grayColor().CGColor
        contentView.addSubview(textLabel)
        
        
        let centertextX = NSLayoutConstraint(item: textLabel!, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0)
        let centertextY = NSLayoutConstraint(item: textLabel!, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0)
        let pinLefttext = NSLayoutConstraint(item: textLabel!, attribute: .trailing, relatedBy: .equal,
                                             toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0)
        let pinRighttext = NSLayoutConstraint(item: textLabel!, attribute: .leading, relatedBy: .equal,
                                              toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let pintop = NSLayoutConstraint(item: imageView!, attribute: .top, relatedBy: .equal,
                                        toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: imageView!, attribute: .trailing, relatedBy: .equal,
                                         toItem: contentView, attribute: .trailing, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: imageView!, attribute: .leading, relatedBy: .equal,
                                          toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0)
        let pinBot = NSLayoutConstraint(item: imageView!, attribute: .bottom, relatedBy: .equal,
                                        toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([pintop, pinBot, pinLeft, pinRight, centertextX, centertextY, pinLefttext, pinRighttext])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
