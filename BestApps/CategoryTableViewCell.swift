//
//  CategoryTableViewCell.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var categoryCellContent: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCellContent.layer.cornerRadius = 10
        categoryCellContent.clipsToBounds = true
        categoryCellContent.layer.borderWidth = 1.0
        categoryCellContent.layer.borderColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 0.6).cgColor
        selectionStyle = .none
    }
    
    func configure(with model: Category) {
        categoryName.text = model.cat_name
        categoryImage.image = UIImage(named: model.cat_name!)
    }
}
