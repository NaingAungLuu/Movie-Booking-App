//
//  DataResponse.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation

struct DataListResponse<T : Codable> : Codable {
    
    var code : Int?
    var data : [T]?
    var message : String?
    
    enum CodingKeys : String , CodingKey {
        case code
        case message
        case data
    }
}
