//
//  MovieScheduleResut.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/08/2021.
//

import Foundation

// MARK: - MovieScheduleResult
struct MovieScheduleResult: Codable {
    let cinemaID: Int?
    let cinema: String?
    let timeslots: [Timeslot]?

    enum CodingKeys: String, CodingKey {
        case cinemaID = "cinema_id"
        case cinema, timeslots
    }
}

// MARK: - Timeslot
struct Timeslot: Codable {
    let cinemaDayTimeslotID: Int?
    let startTime: String?

    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeslotID = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
}
