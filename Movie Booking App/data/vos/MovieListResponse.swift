//
//  MovieVO.swift
//  Movie Booking App
//
//  Created by Harry Jason on 25/07/2021.
//
import Foundation

// MARK: - MovieListResponse
struct MovieListResponse: Codable {
    let code: Int?
    let message: String?
    let data: [MovieListItem]?
}

// MARK: - Datum
struct MovieListItem: Codable {
    let id: Int?
    let originalTitle, releaseDate: String?
    let genres: [String]?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
    }
}
