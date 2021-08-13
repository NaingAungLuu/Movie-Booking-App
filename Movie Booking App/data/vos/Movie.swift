//
//  Movie.swift
//  Movie Booking App
//
//  Created by Harry Jason on 05/06/2021.
//

import Foundation
class Movie {
    var name : String = ""
    var category: String = ""
    var posterImageName : String = ""
    var backdropImageName : String = ""
    var movieLength : String = ""
    var rating : Int = 0
    var tags : [String] = []
    var plotSummary : String = ""
    var castImages : [String] = []
    
    init(
        name : String,
        category : String,
        posterImageName : String,
        backdropImageName : String,
        movieLength : String,
        rating : Int ,
        tags : [String],
        plotSummary : String,
        castImages : [String]
    ){
        self.name = name
        self.category = category
        self.posterImageName = posterImageName
        self.backdropImageName = backdropImageName
        self.movieLength = movieLength
        self.rating = rating
        self.tags = tags
        self.plotSummary = plotSummary
        self.castImages = castImages
    }
    
}
