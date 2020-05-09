//
//  FeedModel.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

struct FeedModel: Codable {
    let feed: Feed
    
    struct Feed: Codable {
        let entry: [Entry]
        
        struct Entry: Codable {
            
        }
    }
}
