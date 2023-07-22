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
    @objc dynamic var testPic: String = ""
    @objc dynamic var testTitle: String = ""
    @objc dynamic var testYear: Int = 0
    @objc dynamic var testRating: Double = 0
    @objc dynamic var isLiked: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
