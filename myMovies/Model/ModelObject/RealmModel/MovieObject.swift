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
    @objc dynamic var movieType: String = ""
    dynamic var movieTrailers: List<String> = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
        
    // For unit-tests block
    //
    func changeId(_ id: Int) {
        self.id = id
    }
    
    func changeMoviePicture(_ moviePicture: String) {
        self.moviePicture = moviePicture
    }
    
    func changeMovieTitle(_ movieTitle: String) {
        self.movieTitle = movieTitle
    }
    
    func changeAbout(_ about: String) {
        self.about = about
    }
    
    func changeMovieYear(_ movieYear: Int) {
        self.movieYear = movieYear
    }
    
    func changeIsLikedByUser(_ isLikedByUser: Bool) {
        self.isLikedByUser = isLikedByUser
    }
    
    func changeMovieType(_ movieType: String) {
        self.movieType = movieType
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
    @objc dynamic var movieType: String = ""
    dynamic var movieTrailers: List<String> = List<String>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
