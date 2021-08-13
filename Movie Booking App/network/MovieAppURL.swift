//
//  MovieAppURL.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation
import Alamofire

enum MovieAppURL : URLConvertible {
    case baseUrl
    case login
    case register
    case image(path : String? = "")
    case moviePosterImage(path : String? = "")
    case logout
    case googleLogin
    case facebookLogin
    case movieList(statusType : MovieListStatusType)
    case movieDetails(id : Int)
    case cinemaList
    case movieSchedule(date : String)
    case seatPlan(timeSlotId : Int , bookingDate : String)
    case snackList
    case paymentMethodList
    case userProfile
    case createCard
    case checkout
    
    func asURL() throws -> URL {
        return url
    }
    
    func asImageURL() -> URL? {
        return URL(string: imagePath) ?? nil
    }
    
    func asImageURLString() -> String {
        return imagePath
    }
    
    func asPosterImageURL() -> URL? {
        return URL(string: posterPath) ?? nil
    }
    
    func asPosterImageString() -> String {
        return posterPath
    }
    
    var url : URL {
        return URL(string: NetworkConstants.BASE_URL.appending(apiPath)) ?? URL(fileURLWithPath: "")
    }
    
    private var apiPath : String {
        switch self {
        case .login :
            return NetworkConstants.LOGIN_ENDPOINT
        case .baseUrl :
            return NetworkConstants.BASE_URL
        case .register :
            return NetworkConstants.REGISTER_ENDPOINT
        case .logout :
            return NetworkConstants.LOG_OUT_ENDPOINT
        case .googleLogin :
            return NetworkConstants.GOOGLE_LOG_IN_ENDPOINT
        case .facebookLogin :
            return NetworkConstants.FACEBOOK_LOG_IN_ENDPOINT
        case .cinemaList :
            return NetworkConstants.CINEMA_LIST_ENDPOINT
        case .movieList(let statusType):
            return "\(NetworkConstants.MOVIE_LIST_ENDPOINT)?status=\(statusType.rawValue)"
        case .movieDetails(let movieId):
            return "\(NetworkConstants.MOVIE_DETAIL_ENDPOINT)/\(movieId)"
        case .movieSchedule(let date):
            return "\(NetworkConstants.MOVIE_SCHEDULE_ENDPOINT)?date=\(date)"
        case .seatPlan(let timeSlotId, let bookingDate):
            return "\(NetworkConstants.SEAT_PLAN_ENDPOINT)?cinema_day_timeslot_id=\(timeSlotId)&booking_date=\(bookingDate)"
        case .snackList :
            return NetworkConstants.SNACK_LIST_ENDPOINT
        case .paymentMethodList :
            return NetworkConstants.PAYMENT_METHOD_ENDPOINT
        case .userProfile :
            return NetworkConstants.PROFILE_ENDPOINT
        case .createCard:
            return NetworkConstants.ADD_NEW_CARD_ENDPOINT
        case .checkout:
            return NetworkConstants.CHECKOUT_ENDPOINT
        default :
            return ""
        }
    }
    
    private var imagePath : String {
        switch self {
        case .image(let path):
            return "\(NetworkConstants.BASE_URL)\(path ?? "")"
        default :
            return ""
        }
    }
    
    private var posterPath : String {
        switch self {
        case .moviePosterImage(let path):
            return "\(NetworkConstants.IMAGE_BASE_URL)\(path ?? "")"
        default :
            return ""
        }
    }
    
}
