//
//  DataResponse.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation

struct ErrorResponse : Codable {
    
    var message : String?
    var errors : Errors?
    
    enum CodingKeys : String , CodingKey {
        case message
        case errors
    }
}

struct Errors : Codable {
    let email: [String]?
    let phone: [String]?
}
