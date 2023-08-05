//
//  TMDB_Service.swift
//  myMovies
//
//  Created by Raman Kozar on 05/08/2023.
//

import Foundation

class TMDB_API {
    
    // Parameters
    let apiKey: String
    let currentSession = URLSession.shared
    
    init(apiKey: String, apiURL: URL) {
        self.apiKey = "e2640eea18e40322814e2a977274c411"
    }

    func dataRequest() {
        
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else {
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
