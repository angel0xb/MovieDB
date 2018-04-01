//
//  NetworkManager.swift
//  Copyright © 2017 angel. All rights reserved.
//

import Foundation
import UIKit
//this is the networkmanager
// request movie information
final class NetworkManager {
    
    weak var delegate:NetworkManagerDelegate?
    
    func downloadMovies(search:String){
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=f577af2cbb4000345db688fd4e80ff46&query=\(search)") else{
            print("no movie with \(search)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            
            let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any]
            
         
            if let jsonResponse = json {
                let results = jsonResponse["results"] as! [Any]
                
                DispatchQueue.main.async {
                    var movieDictArray = [[String:Any]]()
                    for movie in results{
                        let movieDict = movie as! [String:Any]
                        movieDictArray += [movieDict]
                        
                    }
                    let movieArray = MovieModel.parseMovieArray(movieArray: movieDictArray)
                    
                    self.delegate?.didDownloadMovies(movieArray: movieArray)
                    }
                
            }
            
        }
        
        task.resume()
    }
    
 
}
