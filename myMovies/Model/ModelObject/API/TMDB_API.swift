//
//  TMDB_Service.swift
//  myMovies
//
//  Created by Raman Kozar on 05/08/2023.
//

// Documentation to the class:
//
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
//

import Foundation
import UIKit

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
    let currentSession = URLSession.shared
    let parserService = JSON_ParsingService()
    
    // constant for cache
    var imageCache = NSCache<NSString, UIImage>()
    
    // Main request-method
    //
    func dataRequest(requestType: APIRequestParameters) {
            
        let stringURL: String = "\(Constants.baseOfTheURL)\(requestType.rawValue)?api_key=\(Constants().apiKey)&language=en-US\(requestType.endOfTheURL)"
        
        guard let apiURL: URL = URL(string: stringURL) else {
            return
        }
                
        let task = currentSession.dataTask(with: apiURL) { data, response, error in
        
            guard let unwrData = data,
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else {
                return
            }
            
            self.parserService.parseJSONData(dataForParsing: unwrData, errorDuringParsing: error)
            
        }
        
        task.resume()
        
    }
    
    // Method for getting/setting posters
    //
    func getSetPosters(withURL url: URL, completion: @escaping (UIImage) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            
            let downloadingTask = currentSession.dataTask(with: request) { [weak self] data, response, error in
                
                guard error == nil,
                      let unwrData = data,
                      let response = response as? HTTPURLResponse, response.statusCode == 200,
                      let `self` = self else {
                    return
                }
                
                guard let image = UIImage(data: unwrData) else {
                    return
                }
                
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                // 1. Query to the posters using getted URL
                DispatchQueue.main.async {
                    // UIImage(named: "image_cover_144_203")
                    completion(image)
                }
                
            }
            
            downloadingTask.resume()
            
        }
        
    }
    
    // Method for getting backdrops
    //
    // Link-template:
    // https://api.themoviedb.org/3/movie/{movie_id}/images?api_key=<<api_key>>
    //
    func getBackdropsForFilmBy(id: Int) {
        
        let idString = String(id)
        let urlString = "\(Constants.baseOfTheURL)\(idString)/images?api_key=\(Constants().apiKey)"
        
        guard let apiURL: URL = URL(string: urlString) else { return }
        
        let backdropsTask = currentSession.dataTask(with: apiURL) { data, response, error in
            
            guard let unwrData = data,
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil else {
                return
            }
            
            self.parserService.parseMovieBackdropsJSONData(parseData: unwrData, parseError: error)
            
        }
        
        backdropsTask.resume()
        
    }
    
    func validateAPIKey(apiKey: String, completion: @escaping (Int) -> Void) {
        
        let apiKeyURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        
        if !verifyURL(urlString: apiKeyURL) {
            return
        }
        
        let headers = [
            "accept": "application/json"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: apiKeyURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            DispatchQueue.main.async {
                completion(httpResponse.statusCode)
            }
            
        })
        
        dataTask.resume()
        
    }
    
    func verifyURL(urlString: String?) -> Bool {
        
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        
        return false
        
    }
    
}
