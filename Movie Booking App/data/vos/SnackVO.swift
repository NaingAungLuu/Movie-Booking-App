//
//  SnackResponse.swift
//  Movie Booking App
//
//  Created by Harry Jason on 08/08/2021.
//


import Foundation

// MARK: - Snack
struct SnackVO: Codable {
    let id: Int?
    let name, description: String?
    let price: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description = "description"
        case price, image
    }
}
