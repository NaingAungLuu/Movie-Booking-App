//
//  MovieSeatVO.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
struct MovieSeatVO {
    var title : String
    var type : String
    
    func isMovieSeatAvailable() -> Bool {
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isMovieSeatTaken() -> Bool {
        return type == SEAT_TYPE_TAKEN
    }
    
    func isMovieSeatRowTitle() -> Bool {
        return type == SEAT_TYPE_TEXT
    }
    
    func isMovieSeatEmpty() -> Bool {
        return type == SEAT_TYPE_EMPTY
    }
    
    func isMovieSeatSelected() -> Bool {
        return type == SEAT_TYPE_SELECTED
    }
}
