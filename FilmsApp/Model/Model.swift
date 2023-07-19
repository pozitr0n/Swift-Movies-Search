//
//  Model.swift
//  FilmsApp
//
//  Created by Raman Kozar on 18/07/2023.
//

import Foundation

class Model {
    
    // Array with liked movies
    var likedMoviesArray: [Item] = []
    var testArray: [Item] = [
        
        Item(id: 0, testPic: "image1", testTitle: "This is the test movie 1", testYear: "2001", testRating: "4.7", isLiked: true),
        Item(id: 1, testPic: "image2", testTitle: "And this is the test movie 2", testYear: "2001", testRating: "5.7", isLiked: false),
        Item(id: 2, testPic: "image3", testTitle: "Movie 3", testYear: "2003", testRating: "8.7", isLiked: true),
        Item(id: 3, testPic: "image4", testTitle: "Movie 4", testYear: "2001", testRating: "4.7", isLiked: false),
        Item(id: 4, testPic: "image5", testTitle: "Movie 5", testYear: "2005", testRating: "6.7", isLiked: false),
        Item(id: 5, testPic: "image6", testTitle: "Movie 6", testYear: "2001", testRating: "3.7", isLiked: false),
        Item(id: 6, testPic: "image7", testTitle: "Movie 7", testYear: "2007", testRating: "4.7", isLiked: true),
        Item(id: 7, testPic: "image8", testTitle: "Movie 8", testYear: "2001", testRating: "1.7", isLiked: false),
        Item(id: 8, testPic: "image9", testTitle: "Movie 9", testYear: "2009", testRating: "5.7", isLiked: false),
        Item(id: 9, testPic: "image10", testTitle: "Movie 10", testYear: "2012", testRating: "6.7", isLiked: true),
        Item(id: 10, testPic: "image11", testTitle: "Movie 11", testYear: "2015", testRating: "9.7", isLiked: false),
        Item(id: 11, testPic: "image12", testTitle: "Movie 12", testYear: "2017", testRating: "9.7", isLiked: false),
        Item(id: 12, testPic: "image13", testTitle: "Movie 13", testYear: "2019", testRating: "8.7", isLiked: true),
        Item(id: 13, testPic: "image14", testTitle: "Movie 14", testYear: "2021", testRating: "6.7", isLiked: false),
        Item(id: 14, testPic: "image15", testTitle: "Movie 15", testYear: "2022", testRating: "5.7", isLiked: true),
        
    ]
    
    var testPic: String?
    var testTitle: String?
    var testYear: String?
    var testRating: String?
    
    init(testPic: String? = nil, testTitle: String? = nil, testYear: String? = nil, testRating: String? = nil) {
        self.testPic = testPic
        self.testTitle = testTitle
        self.testYear = testYear
        self.testRating = testRating
    }
    
    // Method for getting liked movies
    //
    func showMoviesLiked() -> [Item] {
        
        for currMovie in testArray {
            if currMovie.isLiked {
                likedMoviesArray.append(currMovie)
            }
        }
        
        return likedMoviesArray
        
    }

}

class Item {
    
    var id: Int?
    var testPic: String?
    var testTitle: String?
    var testYear: String?
    var testRating: String?
    var isLiked: Bool
    
    init(id: Int?, testPic: String?, testTitle: String?, testYear: String?, testRating: String?, isLiked: Bool) {
        self.id = id
        self.testPic = testPic
        self.testTitle = testTitle
        self.testYear = testYear
        self.testRating = testRating
        self.isLiked = isLiked
    }
    
}
