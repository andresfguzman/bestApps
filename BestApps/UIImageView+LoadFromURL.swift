//
//  UIImageView+LoadFromURL.swift
//  BestApps
//
//  Created by Andrés Guzmán on 12/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(from stringURL: String) {
        guard let imageURL = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
            guard let imageData = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: imageData)
            }
        }.resume()
    }
}
