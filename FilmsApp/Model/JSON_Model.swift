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

class TestDetailPreviewModel {
    
    var testPic: String?
    
    init(testPic: String?) {
        self.testPic = testPic
    }
    
}

class TestDetailPreviewMethods {
    
    func returnTestArray() -> [TestDetailPreviewModel] {
        
        return [
            
            TestDetailPreviewModel(testPic: "100_100_test_preview_1"),
            TestDetailPreviewModel(testPic: "100_100_test_preview_2"),
            TestDetailPreviewModel(testPic: "100_100_test_preview_3"),
            TestDetailPreviewModel(testPic: "100_100_test_preview_4"),
            TestDetailPreviewModel(testPic: nil)
            
        ]
        
    }
    
}
