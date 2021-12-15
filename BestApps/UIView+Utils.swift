//
//  UIView+Utils.swift
//  BestApps
//
//  Created by Andrés Guzmán on 13/12/21.
//  Copyright © 2021 andres. All rights reserved.
//

import UIKit

extension UIView {
    func takeScreenshot() -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: false)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let image = image else {
            return UIImage()
        }
        
        return image
    }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat = 8.0) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
