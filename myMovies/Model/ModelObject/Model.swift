//
//  Model.swift
//  FilmsApp
//
//  Created by Raman Kozar on 18/07/2023.
//

import Foundation
import RealmSwift

// Main RealmSwift class of the application
//
// Contains methods:
//      showMoviesLiked()
//      ratingSort()
//      search()
//      updateFavouriteMovie()
//
class Model {
    
    // Realm object
    let realm = try? Realm()
    
    // Realm movies object
    var moviesObject: Results<MovieObject>? {
        return realm?.objects(MovieObject.self)
    }
    
    // Sorted array
    //
    var arrayHelper: Results<MovieObject>?
    var sortAscending: Bool = false
    
    var likedMoviesObjects: Results<MovieObject>?
    
    // Method for getting liked movies
    //
    func showMoviesLiked() {
        let likeMoviesFilter = NSPredicate(format: "isLikedByUser = true")
        likedMoviesObjects = moviesObject?.filter(likeMoviesFilter)
    }
    
    // Rating method (using closure)
    //
    func ratingSort() {
        arrayHelper = moviesObject?.sorted(byKeyPath: "movieRating", ascending: sortAscending)
    }
    
    // Method for searching data (search field)
    //
    func search(_ searchTextValue: String) {
        let predicate = NSPredicate(format: "movieTitle CONTAINS [c]%@", searchTextValue)
        arrayHelper = moviesObject?.filter(predicate)
    }
    
    // Method for updating liked data
    //
    func updateFavouriteMovie(at item: Int) {
        
        if let movie = moviesObject?[item] {
            
            do {
                try realm?.write {
                    movie.isLikedByUser = !movie.isLikedByUser
                }
            } catch {
                print("Error after trying to update done status, \(error)")
            }
            
        }
        
    }

}
