//
//  MovieModel.swift
//  MovieDB
//
//  Created by MCS Devices on 2/8/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
struct MovieModel  {

    var posterPath:String?
    var adult:Bool
    var overview:String
    var releaseDate:String
    var genreIDs:[Int]
    var id:Int
    var title:String
    var popularity:Float
    var voteAverage:Float

    

    init( posterPath:String,adult:Bool,overview:String,releaseDate:String,genreIDs:[Int],id:Int,title:String,popularity:Float,voteAverage:Float) {
        
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIDs = genreIDs
        self.id = id
        self.title = title
        self.popularity = popularity
        self.voteAverage = voteAverage
    
    }
}



extension MovieModel{
    static func parseMovieArray(movieArray: [[String:Any]]) -> [MovieModel]{
        var parsedMovieArray:[MovieModel] = []
        
        movieArray.forEach{
            var parsedMovie = MovieModel(posterPath: "", adult: false, overview: "", releaseDate: "", genreIDs: [], id: 0, title: "", popularity: 0.0, voteAverage: 0.0)
            parsedMovie.title = ($0[MovieAPI.titleKey] as! String)
            if let posterPathKey = $0[MovieAPI.posterPathKey] as? String {
                parsedMovie.posterPath = posterPathKey
            }
            
            if let adultKey = $0[MovieAPI.adultKey] as? Bool{
                parsedMovie.adult = adultKey
            }
            
            if let overview = $0[MovieAPI.overviewKey] as? String{
                parsedMovie.overview = overview
            }
            
            if let releaseDate = $0[MovieAPI.releaseDateKey] as? String{
                var dateArray = releaseDate.split(separator: "-")
                let date = "\(dateArray[1])/\(dateArray[2])/\(dateArray[0])"

                parsedMovie.releaseDate = date
            }
            
            if let genreIDs = $0[MovieAPI.genreIDsKey] as? [Int]{
                parsedMovie.genreIDs = genreIDs
            }
            
            if let id = $0[MovieAPI.idKey] as? Int{
                parsedMovie.id = id
            }
            
            if let popularity = $0[MovieAPI.popularityKey] as? Float{
                parsedMovie.popularity = popularity
            }
            
            if let voteAverage = $0[MovieAPI.voteAverageKey] as? Float{
                parsedMovie.voteAverage = voteAverage
            }
            
            parsedMovieArray.append(parsedMovie)
        }
        return parsedMovieArray
    }
}
