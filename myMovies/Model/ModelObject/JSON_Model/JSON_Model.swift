//
//  JSON_Model.swift
//  FilmsApp
//
//  Created by Raman Kozar on 17/06/2023.
//

import Foundation

// Main file for working with JSON
//

// The class will perform the task of parsing the data we need
// ** array **
class MovieList: Codable {
    
    let page: Int
    let totalResults: Int?
    let totalPages: Int?
    let results: [MovieResultJSON]
    
}

// The class will perform the task of parsing the data we need
// ** single element **
class MovieResultJSON: Codable {
    
    var id: Int?
    var original_title: String?
    var poster_path: String?
    var release_date: String?
    var overview: String?
    var vote_average: Double?
    var backdrop_path: String?
    
}