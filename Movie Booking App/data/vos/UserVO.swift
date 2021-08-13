//
//  UserVo.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation
// MARK: - UserVO
struct UserVO: Codable {
    let id: Int?
    let name, email, phone: String?
    let totalExpense: Int?
    let profileImage: String?
    let cards: [CreditCard]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
        case cards
    }
}

// MARK: - CreditCard
struct CreditCard: Codable {
    let id: Int?
    let cardHolder, cardNumber, expirationDate, cvc, cardType: String?

    enum CodingKeys: String, CodingKey {
        case id, cvc
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case expirationDate = "expiration_date"
        case cardType = "card_type"
    }
}
