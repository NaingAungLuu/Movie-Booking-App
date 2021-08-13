//
//  UserPreference.swift
//  Movie Booking App
//
//  Created by Harry Jason on 24/07/2021.
//

import Foundation
class UserPreference {
    
    static var userVO : UserVO? {
        set(data) {
            do {
                
                let encoder = JSONEncoder()
                
                let encodedData = try encoder.encode(data)
                
                UserDefaults.standard.setValue(encodedData, forKey: KEY_USER_VO)
            
                
            } catch {
                print("Unable to save userVO to USER_DEFAULTS")
            }
        }
        
        get {
            if let data = UserDefaults.standard.data(forKey: KEY_USER_VO) {
                do {
                    let decoder = JSONDecoder()
                    
                    let userVO = try decoder.decode(UserVO.self, from: data)
                    
                    return userVO
                } catch {
                    print("Unable to retrieve userVO from USER_DEFAULTs")
                }
            }
            return nil
        }
    }
    
    static var authToken : String? {
        
        set(token){
            UserDefaults.standard.setValue(token, forKey: KEY_AUTH_TOKEN)
        }
        
        get {
            if let data = UserDefaults.standard.string(forKey: KEY_AUTH_TOKEN) {
               return data
            }
            return nil
        }
    }
    
    static var selectedMovie : MovieDetailVO? {
        set(data) {
            do {
                
                let encoder = JSONEncoder()
                
                let encodedData = try encoder.encode(data)
                
                UserDefaults.standard.setValue(encodedData, forKey: KEY_SELECTED_MOVIE)
            
                
            } catch {
                print("Unable to save movieVO to USER_DEFAULTS")
            }
        }
        
        get {
            if let data = UserDefaults.standard.data(forKey: KEY_SELECTED_MOVIE) {
                do {
                    let decoder = JSONDecoder()
                    
                    let movieVO = try decoder.decode(MovieDetailVO.self, from: data)
                    
                    return movieVO
                } catch {
                    print("Unable to retrieve movieVO from USER_DEFAULTs")
                }
            }
            return nil
        }
    }
    
    
    static var selectedSeats : [Seat]? {
        set(data) {
            do {
                
                let encoder = JSONEncoder()
                
                let encodedData = try encoder.encode(data)
                
                UserDefaults.standard.setValue(encodedData, forKey: KEY_SELECTED_SEATS)
            
                
            } catch {
                print("Unable to save selectedSeats to USER_DEFAULTS")
            }
        }
        
        get {
            if let data = UserDefaults.standard.data(forKey: KEY_SELECTED_SEATS) {
                do {
                    let decoder = JSONDecoder()
                    
                    let seatsList = try decoder.decode([Seat].self, from: data)
                    
                    return seatsList
                } catch {
                    print("Unable to retrieve selectedSeats from USER_DEFAULTs")
                }
            }
            return nil
        }
    }
    
    static var selectedSnacks : [Int : Int]? {
        set(data) {
            do {
                
                let encoder = JSONEncoder()
                
                let encodedData = try encoder.encode(data)
                
                UserDefaults.standard.setValue(encodedData, forKey: KEY_SELECTED_SNACKS)
            
                
            } catch {
                print("Unable to save selectedSeats to USER_DEFAULTS")
            }
        }
        
        get {
            if let data = UserDefaults.standard.data(forKey: KEY_SELECTED_SNACKS) {
                do {
                    let decoder = JSONDecoder()
                    
                    let seatsList = try decoder.decode([Int : Int].self, from: data)
                    
                    return seatsList
                } catch {
                    print("Unable to retrieve selectedSeats from USER_DEFAULTs")
                }
            }
            return nil
        }
    }
    
    static var selectedDate : String? {
        
        set(token){
            UserDefaults.standard.setValue(token, forKey: KEY_SELECTED_DATE)
        }
        
        get {
            if let data = UserDefaults.standard.string(forKey: KEY_SELECTED_DATE) {
               return data
            }
            return nil
        }
    }
    
    static var selectedTime : Timeslot? {
        set(data) {
            do {
                
                let encoder = JSONEncoder()
                
                let encodedData = try encoder.encode(data)
                
                UserDefaults.standard.setValue(encodedData, forKey: KEY_SELECTED_TIME_SLOT)
            
                
            } catch {
                print("Unable to save TimeSlot to USER_DEFAULTS")
            }
        }
        
        get {
            if let data = UserDefaults.standard.data(forKey: KEY_SELECTED_TIME_SLOT) {
                do {
                    let decoder = JSONDecoder()
                    
                    let timeSlot = try decoder.decode(Timeslot.self, from: data)
                    
                    return timeSlot
                } catch {
                    print("Unable to retrieve TimeSlot from USER_DEFAULTs")
                }
            }
            return nil
        }
    }
    
    static var selectedCinema : MovieScheduleResult? {
        set(data) {
            do {
                
                let encoder = JSONEncoder()
                
                let encodedData = try encoder.encode(data)
                
                UserDefaults.standard.setValue(encodedData, forKey: KEY_SELECTED_CINEMA)
            
                
            } catch {
                print("Unable to save cinema to USER_DEFAULTS")
            }
        }
        
        get {
            if let data = UserDefaults.standard.data(forKey: KEY_SELECTED_CINEMA) {
                do {
                    let decoder = JSONDecoder()
                    
                    let cinema = try decoder.decode(MovieScheduleResult.self, from: data)
                    return cinema
                } catch {
                    print("Unable to retrieve cinema from USER_DEFAULTs")
                }
            }
            return nil
        }
    }
    
    
//    print(UserPreferense.authToken)
//    UserPreference.authToken = "asd;flkasdf;lkj"
    
    static func clearUserData() {
        UserDefaults.standard.removeObject(forKey: KEY_USER_VO)
        UserDefaults.standard.removeObject(forKey: KEY_AUTH_TOKEN)
        UserDefaults.standard.removeObject(forKey: KEY_SELECTED_MOVIE)
        UserDefaults.standard.removeObject(forKey: KEY_SELECTED_SEATS)
        UserDefaults.standard.removeObject(forKey: KEY_SELECTED_SNACKS)
    }
    
}
