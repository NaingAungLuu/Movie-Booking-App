//
//  Router.swift
//  Hello World
//
//  Created by Harry Jason on 22/05/2021.
//

import Foundation
import UIKit
enum StoryBoardName : String {
    case MAIN = "Main"
    case ON_BOARDING = "OnBoarding"
    case TICKET_PURCHASE = "TicketPurchase"
    case LaunchScreen = "LaunchScreen"
    
}

extension UIStoryboard {
    static func onBoardingStoryBoard() -> UIStoryboard {
        UIStoryboard(name: StoryBoardName.ON_BOARDING.rawValue, bundle: nil)
    }
    static func mainStoryBoard() -> UIStoryboard {
        UIStoryboard(name: StoryBoardName.MAIN.rawValue, bundle: nil)
    }
    static func ticketPurchaseStoryBoard() -> UIStoryboard {
        UIStoryboard(name: StoryBoardName.TICKET_PURCHASE.rawValue, bundle: nil)
    }
}

extension UIViewController {
    func navigateToAuthenticationScreen(){
        guard let viewController = UIStoryboard.onBoardingStoryBoard().instantiateViewController(identifier: AuthenticationViewController.identifier)
        as? AuthenticationViewController else {
            return
        }
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        present(viewController, animated: true)
    }
    func navigateToMainScreen(){
        guard let viewController = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MainScreenNavViewController.identifier)
                as? UIViewController else {
            return
        }
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    func navigateToMovieDetailScreen(id : Int){
        guard let viewController = UIStoryboard.mainStoryBoard().instantiateViewController(identifier: MovieDetailViewController.identifier)
                as? MovieDetailViewController else { return }
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        viewController.movieId = id
//        self.present(viewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateToCartScreen(){
        guard let viewController = UIStoryboard.ticketPurchaseStoryBoard().instantiateViewController(identifier: CartViewController.identifier)
                as? CartViewController else {return}
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateToCheckoutScreen(){
        guard let viewController = UIStoryboard.ticketPurchaseStoryBoard().instantiateViewController(identifier: CheckOutViewController.identifier)
                as? CheckOutViewController else {return}
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateToMovieTimeScreen(){
        guard let viewController = UIStoryboard.ticketPurchaseStoryBoard().instantiateViewController(identifier: MovieTimeViewController.identifier)
                as? MovieTimeViewController else {return}
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateToSeatPlanScreen(cinema selectedCinema : MovieScheduleResult , timeSlot selectedTimeSlot : Timeslot, date selectedDate : String ){
        guard let viewController = UIStoryboard.ticketPurchaseStoryBoard().instantiateViewController(identifier: SeatPlanViewController.identifier)
                as? SeatPlanViewController else {return}
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        viewController.cinema = selectedCinema
        viewController.timeSlot = selectedTimeSlot
        viewController.date = selectedDate
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateToTicketScreen(_ ticket : TicketVO){
        guard let viewController = UIStoryboard.ticketPurchaseStoryBoard().instantiateViewController(identifier: TicketViewController.identifier)
                as? TicketViewController else {return}
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        viewController.ticket = ticket
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func navigateBack(){
        self.navigationController?.popViewController(animated: true)
    }
}
