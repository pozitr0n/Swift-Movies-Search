//
//  MovieObject.swift
//  FilmsApp
//
//  Created by Raman Kozar on 22/07/2023.
//

import Foundation
import RealmSwift

// Main realm database object model
//
class MovieObject: Object {
        
    @objc dynamic var id: Int = 0
    @objc dynamic var moviePicture: String = ""
    @objc dynamic var movieTitle: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var movieYear: Int = 0
    @objc dynamic var movieRating: Double = 0.0
    dynamic var moviePreviews: List<String> = List<String>()
    @objc dynamic var isLikedByUser: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

// Main realm database favourite movies
//
class LikedMovieObject: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var moviePicture: String = ""
    @objc dynamic var movieTitle: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var movieYear: Int = 0
    @objc dynamic var movieRating: Double = 0.0
    dynamic var moviePreviews: List<String> = List<String>()
    @objc dynamic var isLikedByUser: Bool = true
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
