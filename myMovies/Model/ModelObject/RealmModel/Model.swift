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
    
    var likedMoviesObjects: Results<LikedMovieObject>? {
        return realm?.objects(LikedMovieObject.self)
    }
    
    // Rating method (using closure)
    //
    func ratingSort(_ currMovieType: String) {
        
        let arrayHelperBuffering = moviesObject?.filter("movieType == %@", currMovieType)
        arrayHelper = arrayHelperBuffering?.sorted(byKeyPath: "movieRating", ascending: sortAscending)
        
    }
    
    // Method for searching data (search field)
    //
    func search(_ searchTextValue: String, _ currMovieType: String) {
        
        arrayHelper = moviesObject?.filter("movieType == %@", currMovieType).filter("movieTitle CONTAINS [c]%@", searchTextValue)
        
    }
    
    // Method for deleting favourite data
    //
    func deleteLikedItem(at item: Int) {
        
        do {
            
            try realm?.write({
                
                if let likedArrayOfMovies = likedMoviesObjects,
                    let likedObject = likedMoviesObjects?[item] {
                   
                    likedObject.isLikedByUser = !likedObject.isLikedByUser
                    
                    for currCount in likedArrayOfMovies {
                        
                        if currCount.isLikedByUser == false {
                            realm?.delete(currCount)
                        }
                        
                    }
                }
                
            })
            
        } catch {
            print("Error saving done status, \(error)")
        }
        
    }
    
    // Method for updating favourite movie
    //
    func updateFavouriteMovie(at item: Int, controllerType: ControllerType, gettingArrayHelper: Results<MovieObject>?) {
       
        if controllerType == .main {
            
            // Created optional binding for the object
            if let movie = gettingArrayHelper?[item] {
                
                do {
                    
                    try realm?.write ({
                        
                        // revert like
                        movie.isLikedByUser = !movie.isLikedByUser
                        
                        guard let currID = gettingArrayHelper?[item].id else {
                            return
                        }
                        
                        let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
                        let likedScopeValue = likedScope?.first
                        
                        if likedScopeValue == nil && movie.isLikedByUser == true {
                            
                            let object           = LikedMovieObject()
                            
                            object.id            = movie.id
                            object.moviePicture  = movie.moviePicture
                            object.movieTitle    = movie.movieTitle
                            object.about         = movie.about
                            object.movieYear     = movie.movieYear
                            object.movieRating   = movie.movieRating
                            object.moviePreviews = movie.moviePreviews
                            object.movieType     = movie.movieType
                            object.movieTrailers = movie.movieTrailers
                            
                            realm?.add(object, update: .all)
                            
                        }
                        
                        if likedScopeValue != nil && movie.isLikedByUser == false {
                            realm?.delete(likedScopeValue!)
                        }
                        
                    })
                    
                } catch {
                    print("Error saving done status, \(error)")
                }
                
            }
            
        }
        
        if controllerType == .favourite {
            
            // Created optional binding for the object
            if let movie = likedMoviesObjects?[item] {
                
                do {
                    
                    try realm?.write ({
                        
                        guard let currID = likedMoviesObjects?[item].id else {
                            return
                        }
                        
                        let likedScopeOld = realm?.objects(MovieObject.self).filter("id == %@", currID)
                        let likedScopeOldValue = likedScopeOld?.first
                        
                        if likedScopeOldValue != nil {
                            
                            // revert like
                            likedScopeOldValue!.isLikedByUser = !movie.isLikedByUser
                            
                            let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", currID)
                            let likedScopeValue = likedScope?.first
                            
                            if likedScopeValue == nil && likedScopeOldValue!.isLikedByUser == true {
                                
                                let object = LikedMovieObject()
                                
                                object.id            = likedScopeOldValue!.id
                                object.moviePicture  = likedScopeOldValue!.moviePicture
                                object.movieTitle    = likedScopeOldValue!.movieTitle
                                object.about         = likedScopeOldValue!.about
                                object.movieYear     = likedScopeOldValue!.movieYear
                                object.movieRating   = likedScopeOldValue!.movieRating
                                object.movieType     = likedScopeOldValue!.movieType
                                object.movieTrailers = likedScopeOldValue!.movieTrailers
                                
                                realm?.add(object, update: .all)
                                
                            }
                            
                            
                            if likedScopeValue != nil && likedScopeOldValue!.isLikedByUser == false {
                                realm?.delete(likedScopeValue!)
                            }
                            
                        }
                        
                    })
                    
                } catch {
                    print("Error saving done status, \(error)")
                }
                
            }
            
        }
        
    }

}

// Technical enum
//
enum ControllerType {
    
    case main
    case favourite
    
}
