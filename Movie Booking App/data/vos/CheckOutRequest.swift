// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let checkOutRequest = try? newJSONDecoder().decode(CheckOutRequest.self, from: jsonData)

import Foundation

// MARK: - CheckOutRequest
struct CheckOutRequest: Codable {
    let cinemaDayTimeslotID: Int?
    let seatNumber, bookingDate: String?
    var row : String?
    let totalPrice, movieID, cardID, cinemaID: Int?
    let snacks: [SnackAmount]?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case totalPrice = "total_price"
        case movieID = "movie_id"
        case cardID = "card_id"
        case cinemaID = "cinema_id"
        case snacks, row
    }
}

// MARK: - Snack
struct SnackAmount: Codable {
    let id, quantity: Int?
}
