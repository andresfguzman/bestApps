//
//  DBHelper.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class DBHelper: NSObject {
  
  static let Instance = DBHelper()
  
  func saveAllData(rawJsonData: AnyObject){
    
    let wellFormedData = JSON(rawJsonData)
    let appsData = wellFormedData["feed"]["entry"].arrayValue
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let fetchRequest = NSFetchRequest(entityName:"App")
    let entityDescription = NSEntityDescription.entityForName("App", inManagedObjectContext: managedObjectContext)
    
    for app in appsData{
      let app_id = app["id"]["attributes"]["im:id"].stringValue
      let predicate = NSPredicate(format: "%K == %@", "app_id", app_id)
      fetchRequest.predicate = predicate
      do{
        let fetchedResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [App]
        // if there are any result, we just update the entity
        if let results = fetchedResults {
          if (results.count > 0) {
            let currentApp = results[0]
            currentApp.app_name = app["im:name"]["label"].stringValue
            currentApp.app_summary = app["summary"]["label"].stringValue
            currentApp.app_price = app["im:price"]["attributes"]["amount"].stringValue
            currentApp.app_link = app["link"]["attributes"]["href"].stringValue
            currentApp.cat_id = app["category"]["attributes"]["im:id"].stringValue
            currentApp.app_image1 = app["im:image"][0]["label"].stringValue
            currentApp.app_image2 = app["im:image"][1]["label"].stringValue
            currentApp.app_image3 = app["im:image"][2]["label"].stringValue
            saveCategories(app["category"])
            continue
          }
        }
        let currentApp = App(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        currentApp.app_id = app["id"]["attributes"]["im:id"].stringValue
        currentApp.app_name = app["im:name"]["label"].stringValue
        currentApp.app_summary = app["summary"]["label"].stringValue
        currentApp.app_price = app["im:price"]["attributes"]["amount"].stringValue
        currentApp.app_link = app["link"]["attributes"]["href"].stringValue
        currentApp.cat_id = app["category"]["attributes"]["im:id"].stringValue
        currentApp.app_image1 = app["im:image"][0]["label"].stringValue
        currentApp.app_image2 = app["im:image"][1]["label"].stringValue
        currentApp.app_image3 = app["im:image"][2]["label"].stringValue
        saveCategories(app["category"])
        
      }catch {
        print("error al guardar datos")
      }
    }
    
    do{
      try managedObjectContext.save()
    }catch{
      print("problemas al guardar el contexto de las aplicaciones.")
    }
  }
  
  func saveCategories(categoryObject: JSON){
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let fetchRequest = NSFetchRequest(entityName:"Category")
    let entityDescription = NSEntityDescription.entityForName("Category", inManagedObjectContext: managedObjectContext)
    
    let cat_id = categoryObject["attributes"]["im:id"].stringValue
    let predicate = NSPredicate(format: "%K == %@", "cat_id", cat_id)
    fetchRequest.predicate = predicate
    
    do{
      let fetchedResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Category]
      // if there are any result, we just update the entity
      if let results = fetchedResults {
        if (results.count > 0) {
          let currentCat = results[0]
          currentCat.cat_name = categoryObject["attributes"]["label"].stringValue
        } else {
          let currentCat = Category(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
          currentCat.cat_id = cat_id
          currentCat.cat_name = categoryObject["attributes"]["label"].stringValue
        }
      }
      
    }catch {
      print("error al guardar datos")
    }
    
    do{
      try managedObjectContext.save()
    }catch{
      print("problemas al guardar el contexto de las aplicaciones.")
    }
    
  }

}