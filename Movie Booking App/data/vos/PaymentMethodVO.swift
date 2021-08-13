//
//  PaymentMethodVO.swift
//  Movie Booking App
//
//  Created by Harry Jason on 08/08/2021.
//


import Foundation

// MARK: - PaymentMethodVO
struct PaymentMethodVO: Codable {
    let id: Int?
    let name, description: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description = "description"
    }
}
