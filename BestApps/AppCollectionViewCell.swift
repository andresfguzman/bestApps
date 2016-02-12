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
    imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*8/10))
    //imageButton.contentMode = UIViewContentMode.ScaleToFill
    imageView.clipsToBounds = true
    imageView.contentMode = UIViewContentMode.ScaleToFill
    contentView.addSubview(imageView)
    
    textLabel = UILabel(frame: CGRect(x: 1, y: imageView.frame.size.height, width: frame.size.width-2, height: frame.size.height*2/10-2))
    //textLabel.font = UIFont.systemFontOfSize(UIFont.buttonFontSize())
    textLabel.font = UIFont.boldSystemFontOfSize(UIFont.buttonFontSize())
    textLabel.textAlignment = .Center
    textLabel.backgroundColor = UIColor.clearColor()
    contentView.backgroundColor = nil
    contentView.clipsToBounds = true
    contentView.layer.cornerRadius = 10
    contentView.layer.borderWidth = 2.0
    contentView.layer.borderColor = UIColor.grayColor().CGColor
    contentView.addSubview(textLabel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
