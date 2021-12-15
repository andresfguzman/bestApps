//
//  CategoryTableViewCell.swift
//  BestApps
//
//  Created by Andres Guzman on 10/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryCellContent: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryCellContent.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        categoryCellContent.layer.borderWidth = 1.0
        selectionStyle = .none
    }
    
    func configure(with model: Category) {
        categoryName.text = model.cat_name
        if let catName = model.cat_name {
            let shrunkImage = UIImage(named: catName)?.shrink(to: CGSize(width: 400, height: 400))
            categoryImage.image = shrunkImage
        }
    }
    
    override func prepareForReuse() {
        categoryImage.image = nil
        categoryName.text = String()
    }
}
