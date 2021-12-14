//
//  String+Extension.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

extension String {
    static var empty = ""
    
    var localized: String {
        return NSLocalizedString(self, comment: "BEST APP STRING")
    }
}
