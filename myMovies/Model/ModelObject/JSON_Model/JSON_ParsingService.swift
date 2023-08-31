//
//  JSON_ParsingService.swift
//  myMovies
//
//  Created by Raman Kozar on 10/08/2023.
//

import Foundation
import RealmSwift

class JSON_ParsingService {
        
    // Method for native parsing movie-data (from .json)
    //
    func parseJSONData(dataForParsing: Data, errorDuringParsing: Error?, apiKey: String) {
    
        let tmdbAPI = TMDB_API()
        
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
                        
                        tmdbAPI.getBackdropsForFilmBy(id: unwrID, apiKey: apiKey)
                        
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
    
    // Method for native parsing backdrops (from .json)
    //
    func parseMovieBackdropsJSONData(parseData: Data, parseError: Error?) {
        
        do {
            
            let movieData = try JSONDecoder().decode(MovieResultJSON.self, from: parseData)
            let movieID = movieData.id
            
            guard let backdrops = movieData.backdrops else {
                return
            }
            
            let realm = try? Realm()
            
            guard let currentMovie = realm?.object(ofType: MovieObject.self, forPrimaryKey: movieID) else {
                return
            }
            
            do {
                
                try realm?.write ({
                    
                    currentMovie.moviePreviews.removeAll()
                    
                    for backdrop in backdrops {
                        
                        guard let filePath = backdrop.file_path else {
                            return
                        }
                        
                        currentMovie.moviePreviews.append(objectsIn: Array(arrayLiteral: filePath))
                        
                    }
                    
                })
                
            } catch {
                print("Can't update backdrops for film due error: \(error)")
            }
            
        } catch let error {
            print(error)
        }
        
    }
    
}
