//
//  JSON_ParsingService.swift
//  myMovies
//
//  Created by Raman Kozar on 10/08/2023.
//

import Foundation
import RealmSwift

class JSON_ParsingService {
        
    // Method for native parsing JSON
    //
    func parseJSONData(dataForParsing: Data, errorDuringParsing: Error?) {
    
        do {
           
            let movieObject = try JSONDecoder().decode(MovieList.self, from: dataForParsing)
            
            let objectsJSON = movieObject.results
            let realm = try? Realm()
            
            try realm?.write({
                
                for itemJSON in objectsJSON {
                    
                    let object = MovieObject()
                    
                    if let unwrID = itemJSON.id,
                       let unwrPosterPath = itemJSON.poster_path,
                       let unwrOriginalTitle = itemJSON.original_title,
                       let unwrOverview = itemJSON.overview,
                       let unwrReleaseYear = itemJSON.release_date,
                       let unwrMovieRating = itemJSON.vote_average {
                        
                        object.id = unwrID
                        object.moviePicture = unwrPosterPath
                        object.movieTitle = unwrOriginalTitle
                        object.about = unwrOverview
                        object.movieYear = Int(unwrReleaseYear.prefix(4)) ?? 0000
                        object.movieRating = Double(unwrMovieRating)
                        
                        //object.moviePreviews = itemJSON.backdrop_path ?? "N/A"
                        
                        let likedScope = realm?.objects(LikedMovieObject.self).filter("id == %@", itemJSON.id!)
                        
                        if likedScope?.first != nil {
                            object.isLikedByUser = true
                        }
                        
                    }
                    
                    realm?.add(object, update: .all)

                }
                
            })
            
        } catch let error {
            print(error)
        }
        
    }
    
}
