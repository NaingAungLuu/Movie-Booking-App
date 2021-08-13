//
//  CreditCardCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import UIKit

class CreditCardCollectionViewCell: UICollectionViewCell {
    
    var data : CreditCard? {
        didSet {
            bindData()
        }
    }
    
    @IBOutlet weak var lblCardNumbr: UILabel!
    @IBOutlet weak var lblCardHolderName: UILabel!
    @IBOutlet weak var lblExpirationDate: UILabel!
    @IBOutlet weak var lblCardType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func bindData() {
        if let creditCard = data {
            lblCardNumbr.text = "**** **** **** \(creditCard.cardNumber?.suffix(4) ?? "")"
            lblCardHolderName.text = creditCard.cardHolder
            lblExpirationDate.text = creditCard.expirationDate
            lblCardType.text = creditCard.cardType
        }
    }

}
