//
//  AddNewCardViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 13/06/2021.
//

import Foundation
import UIKit
class AddNewCartViewController : BaseViewController {
    @IBOutlet weak var etCardNumber: UITextField!
    @IBOutlet weak var etCardHolderName: UITextField!
    @IBOutlet weak var etExpirationDate: UITextField!
    @IBOutlet weak var etCVCNumber: UITextField!
    @IBAction func onTapConfirm(_ sender: Any) {
        if validated() {
            self.showLoadingDialog()
            let newCard = CreditCard(
                id: nil,
                cardHolder: etCardHolderName.text,
                cardNumber: etCardNumber.text,
                expirationDate: etExpirationDate.text,
                cvc: etCVCNumber.text,
                cardType: "VISA")
            networkAgent.createNewCard(card: newCard) { result in
                self.dismissDialog()
                switch result {
                case .success(_) :
                    self.onDialogDismissed?()
                    self.dismiss(animated: true)
                case .failure(let message):
                    self.showErrorDialog(message: message)
                }
            }
        }

    }
    
    var onDialogDismissed : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func validated() -> Bool {
        return (etCardNumber.text != nil) &&
        (etCardHolderName.text != nil) &&
        (etExpirationDate.text != nil) &&
        (etCVCNumber.text != nil)
    }
    
    
    private func setupTextFields(){
        etCardNumber.useUnderline()
        etCardHolderName.useUnderline()
        etExpirationDate.useUnderline()
        etCVCNumber.useUnderline()
    }

}
