//
//  SeatPlanResult.swift
//  Movie Booking App
//
//  Created by Harry Jason on 07/08/2021.
//

import Foundation

// MARK: - SeatPlanResult
struct SeatPlanResponse: Codable {
    let code: Int?
    let message: String?
    let data: [[Seat]]?
}

// MARK: - Datum
struct Seat: Codable {
    let id: Int?
    var type: SeatState?
    let seatName, symbol: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case id, type
        case seatName = "seat_name"
        case symbol, price
    }
}

enum SeatState: String, Codable {
    case AVAILABLE = "available"
    case space = "space"
    case RESERVED = "taken"
    case text = "text"
    case SELECTED = "selected"
}
