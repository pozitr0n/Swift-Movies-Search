//
//  JSON_Model.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import Foundation

// Main class for working with JSON
// The class will perform the task of parsing the data we need
//
class JSON_Model: Codable {
    
    var original_title: String?
    var poster_path: String?
    var release_date: String?
    var overview: String?
    var vote_average: Double?
    var backdrop_path: String?
    
}

class TestModel {
    
    var testPic: String?
    var testTitle: String?
    var testYear: String?
    var testRating: String?
    
    init(testPic: String?, testTitle: String?, testYear: String?, testRating: String?) {
        self.testPic = testPic
        self.testTitle = testTitle
        self.testYear = testYear
        self.testRating = testRating
    }

}

class TestMethods {
    
    func returnTestArray() -> [TestModel] {
        
        return [
            
            TestModel(testPic: "image1", testTitle: "This is the test movie 1", testYear: "2001", testRating: "4.7"),
            TestModel(testPic: "image2", testTitle: "And this is the test movie 2", testYear: "2001", testRating: "5.7"),
            TestModel(testPic: "image3", testTitle: "Movie 3", testYear: "2003", testRating: "8.7"),
            TestModel(testPic: "image4", testTitle: "Movie 4", testYear: "2001", testRating: "4.7"),
            TestModel(testPic: "image5", testTitle: "Movie 5", testYear: "2005", testRating: "6.7"),
            TestModel(testPic: "image6", testTitle: "Movie 6", testYear: "2001", testRating: "3.7"),
            TestModel(testPic: "image7", testTitle: "Movie 7", testYear: "2007", testRating: "4.7"),
            TestModel(testPic: "image8", testTitle: "Movie 8", testYear: "2001", testRating: "1.7"),
            TestModel(testPic: "image9", testTitle: "Movie 9", testYear: "2009", testRating: "5.7"),
            TestModel(testPic: "image10", testTitle: "Movie 10", testYear: "2012", testRating: "6.7"),
            TestModel(testPic: "image11", testTitle: "Movie 11", testYear: "2015", testRating: "9.7"),
            TestModel(testPic: "image12", testTitle: "Movie 12", testYear: "2017", testRating: "9.7"),
            TestModel(testPic: "image13", testTitle: "Movie 13", testYear: "2019", testRating: "8.7"),
            TestModel(testPic: "image14", testTitle: "Movie 14", testYear: "2021", testRating: "6.7"),
            TestModel(testPic: "image15", testTitle: "Movie 15", testYear: "2022", testRating: "5.7"),
            
        ]
        
    }
    
}
