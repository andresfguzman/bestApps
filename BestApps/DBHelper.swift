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
    
    
    /*
     Método para guardar todos los elementos recibidos en el Json del webservice (apps con sus atributos)
     Este método actualiza los datos si ya existen en la base de datos y si no los crea.
     Queda pendiente como mejora la implementación de un batch que permita la eliminación local de los elementos que ya no hacen parte del webservice.
     */
    
    func saveAllData(rawJsonData: AnyObject){
        
        let wellFormedData = JSON(rawJsonData)
        let appsData = wellFormedData["feed"]["entry"].arrayValue
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"App")
        let entityDescription = NSEntityDescription.entity(forEntityName: "App", in: managedObjectContext)
        
        for app in appsData{
            let app_id = app["id"]["attributes"]["im:id"].stringValue
            let predicate = NSPredicate(format: "%K == %@", "app_id", app_id)
            fetchRequest.predicate = predicate
            do{
                let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [App]
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
                        saveCategories(categoryObject: app["category"])
                        continue
                    }
                }
                let currentApp = App(entity: entityDescription!, insertInto: managedObjectContext)
                
                currentApp.app_id = app["id"]["attributes"]["im:id"].stringValue
                currentApp.app_name = app["im:name"]["label"].stringValue
                currentApp.app_summary = app["summary"]["label"].stringValue
                currentApp.app_price = app["im:price"]["attributes"]["amount"].stringValue
                currentApp.app_link = app["link"]["attributes"]["href"].stringValue
                currentApp.cat_id = app["category"]["attributes"]["im:id"].stringValue
                currentApp.app_image1 = app["im:image"][0]["label"].stringValue
                currentApp.app_image2 = app["im:image"][1]["label"].stringValue
                currentApp.app_image3 = app["im:image"][2]["label"].stringValue
                saveCategories(categoryObject: app["category"])
                
            }catch {
                print("Error al consultar los datos.")
            }
        }
        // Se guarda el contexto actual con los objetos que se crearon en él
        do{
            try managedObjectContext.save()
        }catch{
            print("problemas al guardar el contexto de las aplicaciones.")
        }
    }
    
    /*
     Método para guardar en la base de datos las categorias que se encontraron en los elementos del webservice (hace parte del método de saveAllData.
     */
    
    func saveCategories(categoryObject: JSON){
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Category")
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)
        
        let cat_id = categoryObject["attributes"]["im:id"].stringValue
        let predicate = NSPredicate(format: "%K == %@", "cat_id", cat_id)
        fetchRequest.predicate = predicate
        
        do{
            let fetchedResults = try managedObjectContext.fetch(fetchRequest) as? [Category]
            // if there are any result, we just update the entity
            if let results = fetchedResults {
                if (results.count > 0) {
                    let currentCat = results[0]
                    currentCat.cat_name = categoryObject["attributes"]["label"].stringValue
                } else {
                    let currentCat = Category(entity: entityDescription!, insertInto: managedObjectContext)
                    currentCat.cat_id = cat_id
                    currentCat.cat_name = categoryObject["attributes"]["label"].stringValue
                }
            }
            
        }catch {
            print("Error al recuperar los datos.")
        }
        
        do{
            try managedObjectContext.save()
        }catch{
            print("problemas al guardar el contexto de las categorias..")
        }
        
    }
    
    /*
     Método para obtener todos los datos de cualquier entidad de la base de datos actual. Para recuperarlos debidamente se deben forzar a los objetos que se desean obtener (p.e managedObjectByName(atributos) as! [Category]
     */
    
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
