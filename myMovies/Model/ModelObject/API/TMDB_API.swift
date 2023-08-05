//
//  TMDB_Service.swift
//  myMovies
//
//  Created by Raman Kozar on 05/08/2023.
//

// Documentation to the class:
// It has 5 variants of the queries: Popular | Latest | Now Playing | Top Rated | Upcoming
// Popular:
// https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1

// Latest:
// https://api.themoviedb.org/3/movie/latest?api_key=<<api_key>>&language=en-US

// Now Playing:
// https://api.themoviedb.org/3/movie/now_playing?api_key=<<api_key>>&language=en-US&page=1

// Top Rated:
// https://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>&language=en-US&page=1

// Upcoming:
// https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1

import Foundation

// Enum contains all the variants of the queries
//
enum APIRequestParameters: String {
   
    case latest     = "latest"
    case popular    = "popular"
    case nowPlaying = "now_playing"
    case topRated   = "top_rated"
    case upcoming   = "upcoming"
    
    var endOfTheURL: String {
        return self.rawValue == "latest" ? "" : "&page=1"
    }
    
}

class TMDB_API {
    
    // Parameters
    let apiKey: String = "e2640eea18e40322814e2a977274c411"
    let baseOfTheURL: String = "https://api.themoviedb.org/3/movie/"
    let currentSession = URLSession.shared
    
    // Main request-method
    //
    func dataRequest(requestType: APIRequestParameters) {
        
        let stringURL: String = "\(baseOfTheURL)\(requestType.rawValue)?api_key=\(apiKey)&language=en-US\(requestType.endOfTheURL)"
        
        guard let apiURL: URL = URL(string: stringURL) else {
            return
        }
                
        let task = currentSession.dataTask(with: apiURL) { data, response, error in
        
            guard let unwrData = data,
                  let dataString = String(data: unwrData, encoding: .utf8),
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else {
                return
            }
            
            print(dataString)
            
        }
        
        task.resume()
        
    }
    
}
