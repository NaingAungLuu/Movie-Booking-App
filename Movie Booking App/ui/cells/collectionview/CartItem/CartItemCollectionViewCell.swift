//
//  CartItemCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 13/06/2021.
//

import UIKit

class CartItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var numberControl: NumberControl!
    
    var onAmountUpdated : ((Int) -> Void)?
    
    var data : SnackVO? {
        didSet {
            updateData()
        }
    }
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSnackName: UILabel!
    @IBOutlet weak var lblSnackDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupListeners()
    }
    
    private func updateData() {
        if let snack = data {
            lblPrice.text = "\(String(snack.price ?? 0)) $"
            lblSnackName.text = snack.name
            lblSnackDescription.text = snack.description ?? ""
        }
    }
    
    private func setupListeners() {
        numberControl.onNumberChange = { value in
            if let snack = self.data {
                let totalPrice = value * (snack.price ?? 1)
                self.onAmountUpdated?(value)
            }
        }
    }

}
