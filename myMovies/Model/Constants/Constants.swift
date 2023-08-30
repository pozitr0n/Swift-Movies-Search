//
//  Constants.swift
//  myMovies
//
//  Created by Raman Kozar on 30/08/2023.
//

import Foundation
import UIKit
import CoreData

// Main constants of the application
//
class Constants {
    
    let apiKey: String = {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return ""
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "APIKeys")
        
        let entityResults = try! managedContext.fetch(fetchRequest)
        
        let apiKeyArray = entityResults.map {
            $0.value(forKey: "apiKey") as! String
        }
        
        return apiKeyArray.isEmpty ? "" : apiKeyArray[0]
        
    }()
    
    static let baseOfTheURL: String = "https://api.themoviedb.org/3/movie/"
    static var imgTMDB_Address = "https://image.tmdb.org/t/p/w500"
    static var imgTMDB_Address_Original = "https://image.tmdb.org/t/p/original"
    
}
