//
//  CheckOutViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import MSPeekCollectionViewDelegateImplementation
import UIKit

class CheckOutViewController : BaseViewController {
    
    @IBOutlet weak var collectionViewCreditCard: UICollectionView!
    @IBOutlet weak var lblPaymentAmount: UILabel!
    
    @IBSegueAction func onTapAddNewCard(_ coder: NSCoder) -> AddNewCartViewController? {
        let viewController = AddNewCartViewController(coder: coder)
        viewController?.onDialogDismissed = {
            self.bindData()
        }
        return viewController
    }
    
    var cardList : [CreditCard]?
    
    
    @IBAction func onTapConfirm(_ sender: Any) {
        
        if let timeSlot = UserPreference.selectedTime,
           let date = UserPreference.selectedDate,
           let cinema = UserPreference.selectedCinema,
           let seats = UserPreference.selectedSeats,
           let movie = UserPreference.selectedMovie,
           let snacks = UserPreference.selectedSnacks {
           
            //Seat Number
            var seatNumberString = ""
            seats.forEach { seat in
                seatNumberString.append("\(seat.seatName ?? ""),")
            }
            seatNumberString.removeLast()
    
            //Card
            let selectedCard = cardList![behavior.currentIndex]
            
            //Snack
            var snackList : [SnackAmount] = []
            snacks.forEach { (id, amount) in
                snackList.append(SnackAmount(id: id, quantity: amount))
            }
            
           var request = CheckOutRequest(
            cinemaDayTimeslotID: timeSlot.cinemaDayTimeslotID,
            seatNumber: seatNumberString,
            bookingDate: date,
            totalPrice: getTotalPrice(),
            movieID: movie.id,
            cardID: selectedCard.id,
            cinemaID: cinema.cinemaID,
            snacks: snackList
           )
            
//            request.row = "O,N"
            
            self.showLoadingDialog()
            networkAgent.checkout(requestData: request) { result in
                switch result {
                case .success(let response) :
                    if let ticket = response.data {
                        self.dismissDialog()
                        self.navigateToTicketScreen(ticket)
                    }
                case .failure(let error) :
                    self.dismissDialog()
                    self.showErrorDialog(message: error)
                }
            }
        }

    }
    @IBOutlet weak var btnBack: UIImageView!
    
    var behavior: MSCollectionViewPeekingBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupListeners()
        bindData()
    }

    
    private func setupListeners(){
        let tapGuestureForBack = UIGestureRecognizer(target: btnBack, action: #selector(onTapBack))
        btnBack.isUserInteractionEnabled = true
        btnBack.addGestureRecognizer(tapGuestureForBack)
    }
    
    @objc func onTapBack(){
        navigateBack()
    }
    
    private func setupCollectionView(){
        behavior = MSCollectionViewPeekingBehavior(cellPeekWidth: 15)
        behavior.cellSpacing = 10
        collectionViewCreditCard.configureForPeekingBehavior(behavior: self.behavior)
        collectionViewCreditCard.delegate = self
        collectionViewCreditCard.dataSource = self
        collectionViewCreditCard.registerCell(identifier: CreditCardCollectionViewCell.identifier)
        
    }
    
    private func bindData() {
        networkAgent.getUserProfile { result in
            switch result {
            case .success(let response) :
                UserPreference.userVO = response.data
                self.cardList = response.data?.cards
                self.collectionViewCreditCard.reloadData()
            case .failure(let error):
                self.showErrorDialog(message: error)
            }
        }
        
        lblPaymentAmount.text = "$ \(String(getTotalPrice()))"
    }
    
    private func getTotalPrice() -> Int {
        if let snackPrice = UserPreference.selectedSnacks, let tickets = UserPreference.selectedSeats {
            var subTotal = 0
            snackPrice.forEach { (id, value) in
                subTotal += value
            }
            tickets.forEach { seat in
                subTotal += (seat.price ?? 0)
            }
            return subTotal
        }
        return 0
    }
    
}

extension CheckOutViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreditCardCollectionViewCell.identifier, for: indexPath)
                as? CreditCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.data = cardList?[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.frame.width) , height: CGFloat(collectionView.frame.height * 0.65))
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
}
