//
//  CoreData.swift
//  myMovies
//
//  Created by Raman Kozar on 31/08/2023.
//

import UIKit
import CoreData

class CoreDataMethods {
    
    // Method for saving data into CoreData
    //
    func saveAPI_KeyIntoCoreData(_ key: String) {
    
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "APIKeys", in: managedContext)!
        let apiKeyForSaving = NSManagedObject(entity: entity, insertInto: managedContext)
        
        apiKeyForSaving.setValue(key, forKey: "apiKey")
        
        try! managedContext.save()
        
    }
    
    // Method for deleteing data from CoreData
    //
    func deleteAPI_KeyFromCoreData() {
     
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            
            try managedContext.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "APIKeys")))
            try managedContext.save()
            
        } catch {
            print("Can't remove all the data from entity")
        }
        
    }
    
}
