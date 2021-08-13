//
//  CinemaResponse.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/08/2021.
//

import Foundation

// MARK: - CinemaResponse
struct CinemaResponse: Codable {
    let id: Int?
    let name, phone, email, address: String?
}
