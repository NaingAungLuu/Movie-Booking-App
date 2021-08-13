//
//  AlamofireNetworkAgentImpl.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation
import Alamofire
import GoogleSignIn

class AlamofireNetworkAgentImpl : NetworkAgentModel {
    
    
    static var shared: NetworkAgentModel = AlamofireNetworkAgentImpl()
    
    var googleSignInCofig = GIDConfiguration.init(clientID: "832157159209-sa0mscj03j7ffrg1vnb21c77ku91bka5.apps.googleusercontent.com")

    func login(email userEmail: String, password: String, onSuccess: ((UserVO) -> Void)?, onFailure: ((String) -> Void)?) {
        let url = MovieAppURL.login
        let parameters : Parameters = [
            "email" : userEmail,
            "password" : password
        ]
        AF.request(url , method: .post , parameters: parameters)
            
            .responseDecodable(of: DataResponse<UserVO>.self) { response in
                switch response.result {
                
                case .success(let userResponse):
                    
                    if let statusCode = userResponse.code, statusCode < 400 {
                        
                        if let token = userResponse.token {
                            UserPreference.authToken = token
                        }
                        
                        if let data = userResponse.data {
                            UserPreference.userVO = data
                            onSuccess?(data)
                        }
                        
                    }
                    else {
                        onFailure?(userResponse.message ?? "")
                    }
                    
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            }
    }
    
    func loginWithGoogle(controller: UIViewController, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        GIDSignIn.sharedInstance.signIn(with: googleSignInCofig, presenting: controller) { user, error in
            guard error == nil else { return } // << Need to handle here
            
            if let gmailAccessToken : String = user?.userID {
                print("Gmail Access Token - \(gmailAccessToken)")
                let url = MovieAppURL.googleLogin
                let parameters : Parameters = [
                    "access-token" : gmailAccessToken
                ]    
                AF.request(url , method: .post, parameters: parameters)
                    .validate(statusCode: 200..<400)
                    .responseDecodable(of: DataResponse<UserVO>.self) { response in
                        switch response.result {
                        case .success(let data):
                            if let userVO = data.data {
                                UserPreference.userVO = userVO
                            }
                            if let token = data.token {
                                UserPreference.authToken = token
                            }
                            if data.code ?? 500 < 400 {
                                onSuccess()
                            } else {
                                onFailure(self.handleError(response))
                            }
                            
                        case .failure(_):
                            onFailure(self.handleError(response))
                        }
                    }
            }
            else if error != nil {
                onFailure(error.debugDescription)
            }
        }
    }
    
    func loginWithFacebook(accessToken : String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        let url = MovieAppURL.facebookLogin
        let parameters : Parameters = [
            "access-token" : accessToken
        ]
        AF.request(url , method: .post, parameters: parameters)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: DataResponse<UserVO>.self) { response in
                switch response.result {
                case .success(let data):
                    if let userVO = data.data {
                        UserPreference.userVO = userVO
                    }
                    if let token = data.token {
                        UserPreference.authToken = token
                    }
                    if data.code ?? 500 < 400 {
                        onSuccess()
                    } else {
                        onFailure(self.handleError(response))
                    }
                    
                case .failure(_):
                    onFailure(self.handleError(response))
                }
            }
    }
    
    func registerWithEmail(name : String ,email emailAddress : String ,phone phoneNumber : String, password : String, onComplete: @escaping (APIResponse<UserVO>) -> Void){
        let url = MovieAppURL.register
        let headers: HTTPHeaders = [
            .accept("*/*")
        ]
        let parameters : Parameters = [
            "name" : name,
            "email" : emailAddress,
            "phone" : phoneNumber,
            "password" : password,
        ]
        
        AF.request(url,method: .post, parameters: parameters ,headers: headers)
            .responseDecodable(of: DataResponse<UserVO>.self) { response in
                switch response.result {
                case .success(let userResponse):
                    if let statusCode = userResponse.code, statusCode < 400 {
                        if let token = userResponse.token {
                            UserPreference.authToken = token
                        }
                        if let data = userResponse.data {
                            UserPreference.userVO = data
                            onComplete(.success(data))
                        }
                    } else {
                        onComplete(.failure(self.handleError(response)))
                    }
                case .failure(let error) :
                    onComplete(.failure(self.handleError(response, error)))
                }
            }
    }
    
    func registerWithGoogle(viewController: UIViewController, name: String, email emailAddress: String, phone phoneNumber: String, password: String, onComplete: @escaping (APIResponse<UserVO>) -> Void) {
        GIDSignIn.sharedInstance.signIn(with: googleSignInCofig, presenting: viewController) { user, error in
            guard error == nil else { return }
            
            if let gmailAccessToken : String = user?.userID {
                print("Gmail Access Token - \(gmailAccessToken)")
                let url = MovieAppURL.register
                let headers: HTTPHeaders = [
                    .accept("*/*")
                ]
                let parameters : Parameters = [
                    "name" : name,
                    "email" : emailAddress,
                    "phone" : phoneNumber,
                    "password" : password,
                    "google-access-token" : gmailAccessToken
                ]
                AF.request(url, method: .post, parameters: parameters ,headers: headers)
                    .validate(statusCode: 200..<400)
                    .responseDecodable(of: DataResponse<UserVO>.self) { response in
                        switch response.result {
                        case .success(let data):
                            if let userVO = data.data {
                                UserPreference.userVO = userVO
                            }
                            if let token = data.token {
                                UserPreference.authToken = token
                            }
                            if data.code ?? 500 < 400 {
                                onComplete(.success(data.data!))
                            } else {
                                onComplete(.failure(self.handleError(response)))
                            }
                            
                        case .failure(_):
                            onComplete(.failure(self.handleError(response)))
                        }
                    }
            }
            else if error != nil {
                onComplete(.failure(error?.localizedDescription ?? "Google Login In Error"))
            }
        }
    }
    
    func registerWithFacebook(accessToken: String, name: String, email emailAddress: String, phone phoneNumber: String, password: String, onComplete: @escaping (APIResponse<UserVO>) -> Void) {
        let url = MovieAppURL.register
        let headers: HTTPHeaders = [
            .accept("*/*")
        ]
        let parameters : Parameters = [
            "name" : name,
            "email" : emailAddress,
            "phone" : phoneNumber,
            "password" : password,
            "facebook-access-token" : accessToken
        ]
        AF.request(url , method: .post, parameters: parameters, headers: headers)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: DataResponse<UserVO>.self) { response in
                switch response.result {
                case .success(let data):
                    if let userVO = data.data {
                        UserPreference.userVO = userVO
                    }
                    if let token = data.token {
                        UserPreference.authToken = token
                    }
                    if data.code ?? 400 < 400 {
                        onComplete(.success(data.data!))
                    } else {
                        onComplete(.failure(self.handleError(response)))
                    }
                    
                case .failure(_):
                    onComplete(.failure(self.handleError(response)))
                }
            }
    }
    
    func getMovieList(statusType: MovieListStatusType, onComplete: @escaping (APIResponse<MovieListResponse>) -> Void) {
        let url = MovieAppURL.movieList(statusType: statusType)
        AF.request(url)
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .success(let movieList):
                    onComplete(.success(movieList))
                case .failure(let error):
                    onComplete(.failure(self.handleError(response)))
                }
            }
    }
    
    func getMovieDetails(movieId: Int, onComplete: @escaping (APIResponse<MovieDetailResponse>) -> Void) {
        let url = MovieAppURL.movieDetails(id: movieId)
        AF.request(url)
            .responseDecodable(of: MovieDetailResponse.self) { response in
                switch response.result {
                case .success(let movieListResponse):
                    onComplete(.success(movieListResponse))
                case .failure(_):
                    onComplete(.failure(self.handleError(response)))
                }
            }
    }
    
    
    func logOut(onComplete: @escaping () -> Void) {

        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
        
        AF.request(MovieAppURL.logout, method: .post, headers: headers)
            .responseDecodable(of: DataResponse<String>.self) { response in
                switch response.result {
                case .success(_):
                    UserPreference.clearUserData()
                    onComplete()
                case .failure(_):
                    print("Log Out Failed")
                    print(self.handleError(response))
                }
            }
    }
    
    func getCinemaList(onComplete: @escaping (APIResponse<DataListResponse<CinemaResponse>>) -> Void) {
        let url = MovieAppURL.cinemaList
        AF.request(url)
            .responseDecodable(of: DataListResponse<CinemaResponse>.self) { result in
                switch result.result {
                case .success(let response) :
                    onComplete(.success(response))
                case .failure(_) :
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
    
    func getMovieSchedule(date : String ,onComplete: @escaping (APIResponse<DataListResponse<MovieScheduleResult>>) -> Void) {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
        let url = MovieAppURL.movieSchedule(date: date)
        AF.request(url, headers: headers)
            .responseDecodable(of: DataListResponse<MovieScheduleResult>.self) { result in
                switch result.result {
                case .success(let response) :
                    onComplete(.success(response))
                case .failure(_) :
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
 
    func getSeatPlan(timeSlotId : Int , date : String , onComplete : @escaping(APIResponse<SeatPlanResponse>) -> Void) {
        let url = MovieAppURL.seatPlan(timeSlotId: timeSlotId, bookingDate: date)
        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
        AF.request(url, headers: headers )
            .responseDecodable(of: SeatPlanResponse.self) { result in
                switch result.result {
                case .success(let response) :
                    onComplete(.success(response))
                case .failure(_):
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
    
    func getPaymentMethods(onComplete : @escaping (APIResponse<DataListResponse<PaymentMethodVO>>) -> Void) {
        let url = MovieAppURL.paymentMethodList
        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
        
        AF.request(url , headers: headers)
            .responseDecodable(of: DataListResponse<PaymentMethodVO>.self) { result in
                switch result.result {
                case .success(let response) :
                    onComplete(.success(response))
                case .failure(_) :
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
    
    func getSnackList(onComplete : @escaping (APIResponse<DataListResponse<SnackVO>>) -> Void) {
        let url = MovieAppURL.snackList
        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
        
        AF.request(url , headers: headers)
            .responseDecodable(of: DataListResponse<SnackVO>.self) { result in
                switch result.result {
                case .success(let response) :
                    onComplete(.success(response))
                case .failure(_) :
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
    
    func getUserProfile(onComplete: @escaping (APIResponse<DataResponse<UserVO>>) -> Void) {
        let url = MovieAppURL.userProfile
        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
        
        AF.request(url , headers: headers)
            .responseDecodable(of: DataResponse<UserVO>.self) { result in
                switch result.result {
                case .success(let response) :
                    onComplete(.success(response))
                case .failure(_) :
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
    
    func createNewCard(card : CreditCard , onComplete: @escaping (APIResponse<DataListResponse<CreditCard>>) -> Void) {
        let url = MovieAppURL.createCard
        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
        
        AF.request(url , method: .post, parameters: card , encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: DataListResponse<CreditCard>.self) { result in
                switch result.result {
                case .success(let response) :
                    onComplete(.success(response))
                case .failure(_) :
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
    
    func checkout(requestData : CheckOutRequest, onComplete: @escaping (APIResponse<DataResponse<TicketVO>>) -> Void) {
        let url = MovieAppURL.checkout
        let headers: HTTPHeaders = [
            .authorization(bearerToken: UserPreference.authToken!),
            .accept("application/json")
        ]
    
        
        AF.request(url , method: .post, parameters: requestData , encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: DataResponse<TicketVO>.self) { result in
                switch result.result {
                case .success(let response) :
                    if response.code ?? 500 < 400 {
                        onComplete(.success(response))
                    } else {
                        onComplete(.failure(self.handleError(result)))
                    }
                case .failure(_) :
                    onComplete(.failure(self.handleError(result)))
                }
            }
    }
    
    
    
    
    
    
    
    
    fileprivate func handleError<T> (
        _ response : Alamofire.DataResponse<T , AFError>,
        _ error : (AFError)? = nil
    ) -> String {
        
        var responseBody : String = ""
        
        var serverErrorMessage : String?
        
        var errorBody : ErrorResponse?
        
        if let responseData = response.data {
            responseBody = String(data: responseData, encoding: .utf8) ?? "Empty Response Body"
            
            errorBody = try? JSONDecoder().decode(ErrorResponse.self, from: responseData)
            serverErrorMessage = errorBody?.message
        }
        
        //Debug Info
        let responseCode = response.response?.statusCode ?? 0
        let sourcePath = response.request?.url?.absoluteString ?? "No Url"
        
        print(
            """
            ===========================
            URL
            -> \(sourcePath)
            
            Status
            -> \(responseCode)
            
            Body
            -> \(responseBody)
            
            Underlying Error
            -> \(String(describing: error?.underlyingError))
            
            Error Description
            -> \(String(describing: error?.errorDescription ?? ""))
            
            =============================
            """
        )
        
        return serverErrorMessage ?? error?.errorDescription ?? "undefined"
    }
    
 
}
