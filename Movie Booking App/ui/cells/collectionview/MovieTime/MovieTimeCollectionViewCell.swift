//
//  MovieTimeCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import UIKit

class MovieTimeCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    
    enum State {
        case SELECTED
        case UNSELECTED
    }
    
    var currentState : State = .UNSELECTED {
        didSet {
            updateState()
        }
    }
    
    var data : String? {
        didSet {
            updateData()
        }
    }
    
    private func updateData() {
        lblTime.text = data ?? ""
    }
    
    private func updateState() {
        switch currentState {
        case .SELECTED:
            layer.borderWidth = 0
            lblTime.textColor = .white
            self.contentView.backgroundColor = ThemeColor.ACCENT
            
        case .UNSELECTED:
            layer.borderWidth = 1
            lblTime.textColor = .black
            self.contentView.backgroundColor = .white
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.borderWidth = 1
        layer.borderColor = ThemeColor.SEAT_AVAILABLE?.cgColor
        layer.cornerRadius = 7
        
//        let selectedBackgroundView = UIView(frame: bounds)
//        selectedBackgroundView.backgroundColor = UIColor(named: "color_accent")
//        self.selectedBackgroundView = selectedBackgroundView
//
//        let unselectedBackgroundView = UIView(frame : bounds)
//        unselectedBackgroundView.backgroundColor = .white
//        self.backgroundView = unselectedBackgroundView
        
        updateState()
        
    }

}
