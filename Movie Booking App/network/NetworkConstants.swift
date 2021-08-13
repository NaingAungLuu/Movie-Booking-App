//
//  NetworkConstants.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation
class NetworkConstants {
    static let BASE_URL = "https://tmba.padc.com.mm"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original/"
    static let LOGIN_ENDPOINT = "/api/v1/email-login"
    static let REGISTER_ENDPOINT = "/api/v1/register"
    static let LOG_OUT_ENDPOINT = "/api/v1/logout"
    static let GOOGLE_LOG_IN_ENDPOINT = "/api/v1/google-login"
    static let FACEBOOK_LOG_IN_ENDPOINT = "/api/v1/facebook-login"
    static let MOVIE_LIST_ENDPOINT = "/api/v1/movies"
    static let MOVIE_DETAIL_ENDPOINT = "/api/v1/movies"
    static let CINEMA_LIST_ENDPOINT = "/api/v1/cinemas"
    static let MOVIE_SCHEDULE_ENDPOINT = "/api/v1/cinema-day-timeslots"
    static let SEAT_PLAN_ENDPOINT = "/api/v1/seat-plan"
    static let PAYMENT_METHOD_ENDPOINT = "/api/v1/payment-methods"
    static let SNACK_LIST_ENDPOINT = "/api/v1/snacks"
    static let PROFILE_ENDPOINT = "/api/v1/profile"
    static let ADD_NEW_CARD_ENDPOINT = "/api/v1/card"
    static let CHECKOUT_ENDPOINT = "/api/v1/checkout"

    
    //Client IDs
    static let GOOGLE_CLIENT_ID = "832157159209-sa0mscj03j7ffrg1vnb21c77ku91bka5.apps.googleusercontent.com"
//    832157159209-sa0mscj03j7ffrg1vnb21c77ku91bka5.apps.googleusercontent.com
//    com.googleusercontent.apps.832157159209-sa0mscj03j7ffrg1vnb21c77ku91bka5\
}

enum MovieListStatusType : String {
    case CURRENT = "current"
    case COMING_SOON = "comingsoon"
}
