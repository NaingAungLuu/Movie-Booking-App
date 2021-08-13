//
//  SeatPlanViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import UIKit
class SeatPlanViewController : BaseViewController {
    
    var cinema : MovieScheduleResult?
    var timeSlot : Timeslot?
    var date : String?
    var totalPrice : Int = 0
    
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblCinemaName: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblTicketCount: UILabel!
    @IBOutlet weak var lblSeatNumbers: UILabel!
    @IBOutlet weak var btnBuyTickets: UIButton!
    
    
    var seatPlan : [[Seat]]?
    var selectedSeats : [Seat] = [] {
        didSet {
            UserPreference.selectedSeats = self.selectedSeats
        }
    }
    
    @IBAction func onTapBuyTickets(_ sender: Any) {
        UserPreference.selectedSeats = self.selectedSeats
        navigateToCartScreen()
    }
    
    @IBAction func onTapBack(_ sender: Any) {
        navigateBack()
    }
    @IBOutlet weak var constraintSeatPlanViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewSeatPlan: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSeatPlanCollectionView()
        showCinemaDetails()
        fetchSeatPlan()
    }
    
    private func setupSeatPlanCollectionView(){
        collectionViewSeatPlan.delegate = self
        collectionViewSeatPlan.dataSource = self
        collectionViewSeatPlan.registerCell(identifier: MovieSeatCollectionViewCell.identifier)
        collectionViewSeatPlan.allowsMultipleSelection = true
    }
    
    private func showCinemaDetails() {
        if let cinemaDetails = cinema {
            lblMovieName.text = UserPreference.selectedMovie?.originalTitle
            lblCinemaName.text = cinemaDetails.cinema ?? ""
            lblSchedule.text = "\(date ?? "") : \(timeSlot?.startTime ?? "")"
        }
    }

    private func fetchSeatPlan() {
        if timeSlot != nil && date != nil {
//            self.showLoadingDialog()
            networkAgent.getSeatPlan(timeSlotId: timeSlot!.cinemaDayTimeslotID!, date: date!) { result in
                self.dismissDialog()
                switch result {
                case .success(let response):
                    self.bindSeatPlanData(response)
                case .failure(let error):
                    self.showErrorDialog(message: error)
                }
            }
        }
    }
    
    private func bindSeatPlanData(_ data : SeatPlanResponse) {
        seatPlan = data.data
        collectionViewSeatPlan.reloadData()
        updateHeight()
    }
    
    private func updateHeight() {
        let rowCount = collectionViewSeatPlan.numberOfSections
        constraintSeatPlanViewHeight.constant = CGFloat((((rowCount * 40)) + ((rowCount))))
        collectionViewSeatPlan.layoutIfNeeded()
    }
    
    private func updateSeatSelectionText() {
        var selectedSeatsText = " "
        selectedSeats.forEach { seat in
            selectedSeatsText.append("\(seat.seatName ?? "") /")
        }
        selectedSeatsText.removeLast()
        lblSeatNumbers.text = selectedSeatsText
        lblTicketCount.text = String(selectedSeats.count)
        btnBuyTickets.setTitle("Buy Tickets for $\(totalPrice)", for: .normal)
    }
    
}

extension SeatPlanViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seatPlan?.first?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return seatPlan?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSeatCollectionViewCell.identifier, for: indexPath)
                as? MovieSeatCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = seatPlan?[indexPath.section][indexPath.row]
        
        cell.onSelectSeat = { seat in
            self.selectedSeats.append(seat)
            self.totalPrice += seat.price ?? 0
            self.updateSeatSelectionText()
        }
        
        cell.onDeselectSeat = { deselectedSeat in
            self.selectedSeats.removeAll { seat in
                return (seat.seatName == deselectedSeat.seatName)
            }
            self.totalPrice -= deselectedSeat.price ?? 0
            self.updateSeatSelectionText()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 16) / CGFloat(seatPlan?.first?.count ?? 0))
        let height = CGFloat(40)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieSeatCollectionViewCell else {
            return
        }
        cell.onTapSeat()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieSeatCollectionViewCell else {
            return
        }
        cell.onTapSeat()
    }
    
}

