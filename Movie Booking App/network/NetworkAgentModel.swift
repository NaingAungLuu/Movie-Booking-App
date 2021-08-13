//
//  NetworkAgentModel.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation
import GoogleSignIn

protocol NetworkAgentModel {
    var googleSignInCofig : GIDConfiguration { get set } 
    func login(email userEmail: String, password: String, onSuccess: ((UserVO) -> Void)?, onFailure: ((String) -> Void)?)
    func logOut(onComplete: @escaping () -> Void)
    func loginWithGoogle(controller: UIViewController, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func loginWithFacebook(accessToken : String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func registerWithGoogle(viewController : UIViewController ,name : String ,email emailAddress : String ,phone phoneNumber : String, password : String, onComplete: @escaping (APIResponse<UserVO>) -> Void)
    func registerWithFacebook(accessToken : String, name : String, email emailAddress : String ,phone phoneNumber : String, password : String, onComplete: @escaping (APIResponse<UserVO>) -> Void)
    func registerWithEmail(name : String ,email emailAddress : String ,phone phoneNumber : String, password : String, onComplete: @escaping (APIResponse<UserVO>) -> Void)
    func getMovieList(statusType : MovieListStatusType , onComplete: @escaping (APIResponse<MovieListResponse>) -> Void)
    func getMovieDetails(movieId : Int , onComplete: @escaping (APIResponse<MovieDetailResponse>) -> Void)
    func getCinemaList(onComplete : @escaping (APIResponse<DataListResponse<CinemaResponse>>) -> Void)
    func getMovieSchedule(date : String , onComplete : @escaping (APIResponse<DataListResponse<MovieScheduleResult>>) -> Void)
    func getSeatPlan(timeSlotId : Int , date : String , onComplete : @escaping(APIResponse<SeatPlanResponse>) -> Void)
    func getPaymentMethods(onComplete : @escaping (APIResponse<DataListResponse<PaymentMethodVO>>) -> Void)
    func getSnackList(onComplete : @escaping (APIResponse<DataListResponse<SnackVO>>) -> Void)
    func getUserProfile(onComplete: @escaping (APIResponse<DataResponse<UserVO>>) -> Void)
    func createNewCard(card : CreditCard , onComplete: @escaping (APIResponse<DataListResponse<CreditCard>>) -> Void)
    func checkout(requestData : CheckOutRequest, onComplete: @escaping (APIResponse<DataResponse<TicketVO>>) -> Void)
}
enum APIResponse<T> {
    case success(T)
    case failure(String)
}
