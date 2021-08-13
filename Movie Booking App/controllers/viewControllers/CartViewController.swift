//
//  CartViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import UIKit
class CartViewController : BaseViewController {
    
    @IBOutlet weak var etPromoCode: UITextField!
    @IBOutlet weak var collectionViewCart: UICollectionView!
    @IBOutlet weak var collectionViewPaymentMethods: UICollectionView!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var onTapBack: UIImageView!
    @IBOutlet weak var constraintCollectionSnackListHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintCollectionPaymentMethodHeight: NSLayoutConstraint!
    
    @IBAction func onTapPay(_ sender: Any) {
        UserPreference.selectedSnacks = snackPrice
        navigateToCheckoutScreen()
    }
    
    var snackList : [SnackVO]?
    var snackPrice : [Int : Int] = [:]
    var paymentMethodList : [PaymentMethodVO]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        etPromoCode.useUnderline()
        setupCollectionViews()
        fetchData()
    }
    
    private func setupCollectionViews() {
        collectionViewCart.registerCell(identifier: CartItemCollectionViewCell.identifier)
        collectionViewCart.delegate = self
        collectionViewCart.dataSource = self
        
        collectionViewPaymentMethods.registerCell(identifier: PaymentMethodCollectionViewCell.identifier)
        collectionViewPaymentMethods.delegate = self
        collectionViewPaymentMethods.dataSource = self
    }
    
    private func fetchData() {
//        self.showLoadingDialog()
        fetchPaymentMethods()
        fetchSnackList()
    }
    
    private func fetchPaymentMethods() {
        networkAgent.getPaymentMethods { result in
            self.dismissDialog()
            switch result {
            case .success(let response) :
                self.paymentMethodList = response.data
                self.collectionViewPaymentMethods.reloadData()
                self.updatePaymentMethodsHeight()
            case .failure(let error):
                self.showErrorDialog(message: error)
            }
        }
    }
    
    private func fetchSnackList() {
        networkAgent.getSnackList { result in
            self.dismissDialog()
            switch result {
            case .success(let response) :
                self.snackList = response.data
                self.collectionViewCart.reloadData()
                self.updateSnackListHeight()
                self.updateSubTotal()
            case .failure(let error):
                self.showErrorDialog(message: error)
            }
        }
    }
    
    private func updatePaymentMethodsHeight() {
        constraintCollectionPaymentMethodHeight.constant = CGFloat((paymentMethodList?.count ?? 1) * 100)
        collectionViewCart.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    private func updateSnackListHeight() {
        constraintCollectionSnackListHeight.constant = CGFloat((snackList?.count ?? 1) * 150)
        collectionViewCart.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
    
    private func updateSubTotal() {
        var subTotal = 0
        snackPrice.forEach { (id, amount) in
            let unitPrice = snackList?.first(where: { $0.id == id})?.price ?? 1
            subTotal += unitPrice * amount
        }
        if let tickets = UserPreference.selectedSeats {
            tickets.forEach { seat in
                subTotal += (seat.price ?? 0)
            }
        }
        lblSubTotal.text = "Sub Total : \(subTotal)$"
        btnPay.setTitle("Pay $ \(subTotal)", for: .normal)
    }
    
}

extension CartViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewCart {
            return snackList?.count ?? 0
        }
        else if collectionView == collectionViewPaymentMethods {
            return paymentMethodList?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewCart {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.identifier, for: indexPath) as? CartItemCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.onAmountUpdated = { amount in
                self.snackPrice[cell.data?.id ?? 0] = amount
                self.updateSubTotal()
            }
            cell.data = snackList?[indexPath.row]
            return cell
        }
        else if collectionView == collectionViewPaymentMethods {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentMethodCollectionViewCell.identifier, for: indexPath) as? PaymentMethodCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = paymentMethodList?[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewCart {
            let width = collectionView.frame.width
            let height = CGFloat(120)
            return CGSize(width: width, height: height)
        } else {
            let width = collectionView.frame.width
            let height = CGFloat(80)
            return CGSize(width: width, height: height)
        }
    }
    
    
}
