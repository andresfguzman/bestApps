//
//  AppDelegate+CoreData.swift
//  BestApps
//
//  Created by Andrés Guzmán on 13/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}
