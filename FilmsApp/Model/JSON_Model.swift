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
