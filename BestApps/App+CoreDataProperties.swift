//
//  App+CoreDataProperties.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension App {
    
    @NSManaged var app_id: String?
    @NSManaged var app_name: String?
    @NSManaged var app_link: String?
    @NSManaged var app_image1: String?
    @NSManaged var app_image2: String?
    @NSManaged var app_image3: String?
    @NSManaged var app_release: String?
    @NSManaged var app_price: String?
    @NSManaged var app_summary: String?
    @NSManaged var cat_id: String?
    
}
