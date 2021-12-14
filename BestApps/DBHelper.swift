//
//  DBHelper.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import UIKit
import CoreData

final class DBHelper: NSObject {
    
    static let Instance = DBHelper()
    
    func save(_ payload: Payload) {
        
        let appsData = payload.feed.entry
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"App")
        let entityDescription = NSEntityDescription.entity(forEntityName: "App", in: managedObjectContext)
        
        for app in appsData{
            let app_id = app.id.attributes.id
            let predicate = NSPredicate(format: "%K == %@", "app_id", app_id)
            fetchRequest.predicate = predicate
            
            do {
                let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [App]
                // if there are any result, we just update the entity
                if let results = fetchedResults {
                    if (results.count > 0) {
                        let currentApp = results[0]
                        currentApp.app_name = app.name.label
                        currentApp.app_summary = app.summary.label
                        currentApp.app_price = app.price.attributes.amount
                        currentApp.app_link = app.link.first?.attributes.href
                        currentApp.cat_id = app.category.attributes.id
                        currentApp.app_image1 = app.images[0].label
                        currentApp.app_image2 = app.images[1].label
                        currentApp.app_image3 = app.images[2].label
                        saveCategories(categoryObject: app.category)
                        continue
                    }
                }
                let currentApp = App(entity: entityDescription!, insertInto: managedObjectContext)
                
                currentApp.app_id = app.id.attributes.id
                currentApp.app_name = app.name.label
                currentApp.app_summary = app.summary.label
                currentApp.app_price = app.price.attributes.amount
                currentApp.app_link = app.link.first?.attributes.href
                currentApp.cat_id = app.category.attributes.id
                currentApp.app_image1 = app.images[0].label
                currentApp.app_image2 = app.images[1].label
                currentApp.app_image3 = app.images[2].label
                saveCategories(categoryObject: app.category)
                
            } catch {
                print("Error getting data.")
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("There was a problem saving the context")
        }
    }
    
    private func saveCategories(categoryObject: ServiceCategory){
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Category")
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)
        
        let cat_id = categoryObject.attributes.id
        let predicate = NSPredicate(format: "%K == %@", "cat_id", cat_id)
        fetchRequest.predicate = predicate
        
        do{
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [Category]
            // if there are any result, we just update the entity
            if let results = fetchedResults {
                if (results.count > 0) {
                    let currentCat = results[0]
                    currentCat.cat_name = categoryObject.attributes.label
                } else {
                    let currentCat = Category(entity: entityDescription!, insertInto: managedObjectContext)
                    currentCat.cat_id = cat_id
                    currentCat.cat_name = categoryObject.attributes.label
                }
            }
            
        } catch {
            print("Error getting data")
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("There was a problem saving the context")
        }
        
    }
    
    func managedObjectsByName(entityName: String, hasPredicate: Bool = false, predicateFormat: String = "%K == %@", predicateFilterParameter: String = "cat_id", predicateData: CVarArg = 0) -> [NSManagedObject]?{
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if hasPredicate{
            let predicate = NSPredicate(format: predicateFormat, predicateFilterParameter, predicateData)
            fetchRequest.predicate = predicate
        }
        do{
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            // if there are any result, we just update the entity
            if (fetchedResults.count > 0) {
                return fetchedResults
            }
        }catch {
            print("error al guardar datos")
        }
        return nil
    }
}
