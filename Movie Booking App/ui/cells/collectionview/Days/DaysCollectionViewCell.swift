//
//  DaysCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import UIKit

class DaysCollectionViewCell: SelectableCollectionViewCell {
    
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var data : Date? {
        didSet {
            updateDate()
        }
    }
    
    override func onSelected() {
        containerView.backgroundColor = .white
        lblDay.textColor = ThemeColor.ACCENT
        lblDate.textColor = ThemeColor.ACCENT
    }
    
    override func onDeselected() {
        containerView.backgroundColor = ThemeColor.ACCENT
        lblDay.textColor = .white
        lblDate.textColor = .white
    }
    
    private func updateDate() {
        if let date = data {
            let day = date.getDayInString()
            let date = date.getDateInString()
            lblDay.text = String(describing: day)
            lblDate.text = String(describing: date)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
