//
//  Payload.swift
//  BestApps
//
//  Created by Andrés Guzmán on 12/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

struct Payload: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let entry: [Entry]
}

struct Entry: Codable {
    let name: AppName
    let id: AppId
    let summary: Summary
    let price: Price
    let link: [ServiceLink]
    let category: ServiceCategory
    let images: [ServiceImage]
    
    enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case images = "im:image"
        case price = "im:price"
        case summary
        case link
        case category
        case id
    }
}

struct AppName: Codable {
    let label: String
}

struct AppId: Codable {
    let attributes: Attributes
    
    struct Attributes: Codable {
        let id: String
        
        enum CodingKeys: String, CodingKey {
            case id = "im:id"
        }
    }
}

struct ServiceImage: Codable {
    let label: String
}

struct Summary: Codable {
    let label: String
}

struct Price: Codable {
    let attributes: Attributes
    
    struct Attributes: Codable {
        let amount: String
        let currency: String
    }
}

struct ServiceLink: Codable {
    let attributes: Attributes
    
    struct Attributes: Codable {
        let href: String
    }
}

struct ServiceCategory: Codable {
    let attributes: Attributes
    
    struct Attributes: Codable {
        let id: String
        let label: String
        
        enum CodingKeys: String, CodingKey {
            case id = "im:id"
            case label
        }
    }
}
