//
//  MovieMock.swift
//  myMovies
//
//  Created by Raman Kozar on 30/08/2023.
//

import Foundation

class MovieMock: MovieObject {

    // counters that control the number of times the method will be called
    var changeIdCounter: Int = 0
    var changeMoviePictureCounter: Int = 0
    var changeMovieTitleCounter: Int = 0
    var changeAboutCounter: Int = 0
    var changeMovieYearCounter: Int = 0
    var changeMovieRatingCounter: Int = 0
    var changeIsLikedByUserConuter: Int = 0
    var changeMovieTypeConuter: Int = 0
    
    // variables for fixing whether this or that method was called
    var changeIdCalled = false
    var changeMoviePictureCalled = false
    var changeMovieTitleCalled = false
    var changeAboutCalled = false
    var changeMovieYearCalled = false
    var changeMovieRatingCalled = false
    var changeIsLikedByUserCalled = false
    var changeMovieTypeCalled = false
    
    override func changeId(_ id: Int) {
        
        changeIdCounter += 1
        changeIdCalled = true
        
        self.id = id
        
    }
    
    override func changeMoviePicture(_ moviePicture: String) {
        
        changeMoviePictureCounter += 1
        changeMoviePictureCalled = true
        
        self.moviePicture = moviePicture
        
    }
    
    override func changeMovieTitle(_ movieTitle: String) {
        
        changeMovieTitleCounter += 1
        changeMovieTitleCalled = true
        
        self.movieTitle = movieTitle
        
    }
    
    override func changeAbout(_ about: String) {
        
        changeAboutCounter += 1
        changeAboutCalled = true
        
        self.about = about
        
    }
    
    override func changeMovieYear(_ movieYear: Int) {
        
        changeMovieYearCounter += 1
        changeMovieYearCalled = true
        
        self.movieYear = movieYear
        
    }
    
    override func changeIsLikedByUser(_ isLikedByUser: Bool) {
        
        changeIsLikedByUserConuter += 1
        changeIsLikedByUserCalled = true
        
        self.isLikedByUser = isLikedByUser
        
    }
    
    override func changeMovieType(_ movieType: String) {
        
        changeMovieTypeConuter += 1
        changeMovieTypeCalled = true
        
        self.movieType = movieType
        
    }
    
}
