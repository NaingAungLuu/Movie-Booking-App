//
//  PaymentMethodCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 08/08/2021.
//

import UIKit

class PaymentMethodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblPaymentName: UILabel!
    @IBOutlet weak var lblPaymentDescription: UILabel!
    
    var data : PaymentMethodVO? {
        didSet {
            bindData()
        }
    }
    
    private func bindData() {
        if let paymentMethod = data {
            lblPaymentName.text = paymentMethod.name
            lblPaymentDescription.text = paymentMethod.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
