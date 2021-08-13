//
//  MovieSeatCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import UIKit

class MovieSeatCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerViewSeat: UIView!
    @IBOutlet weak var lblSeat: UILabel!
    
    var title : String = ""
    var data : Seat? {
        didSet {
            if data != nil {
                bindData()
            }
        }
    }
    
    
    var currentState : SeatState = SeatState.AVAILABLE
    
    var onSelectSeat : ((Seat) -> Void)?
    var onDeselectSeat : ((Seat) -> Void)?
    
    func onTapSeat() {
        switch currentState {
        case .AVAILABLE :
            currentState = .SELECTED
            data?.type = SeatState.SELECTED
            bindData()
            onSelectSeat?(data!)
        case .RESERVED : return
        case .SELECTED :
            currentState = .AVAILABLE
            data?.type = SeatState.AVAILABLE
            bindData()
            onDeselectSeat?(data!)
        default : return
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindData(){
        if let seat = data {
            lblSeat.text = seat.seatName
            title = seat.seatName ?? ""
            
            switch seat.type {
            case .AVAILABLE:
                containerViewSeat.clipsToBounds = true
                containerViewSeat.backgroundColor = ThemeColor.SEAT_AVAILABLE
                containerViewSeat.layer.cornerRadius = 10
                containerViewSeat.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
                lblSeat.text = ""
                currentState = .AVAILABLE
            case .space :
                containerViewSeat.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                lblSeat.text = ""
                currentState = .space
            case .RESERVED:
                containerViewSeat.clipsToBounds = true
                containerViewSeat.backgroundColor = ThemeColor.SEAT_TAKEN
                containerViewSeat.layer.cornerRadius = 10
                containerViewSeat.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
                lblSeat.text = ""
                currentState = .RESERVED
            case .SELECTED:
                lblSeat.text = String(seat.id ?? 0)
                containerViewSeat.layer.cornerRadius = 10
                lblSeat.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                containerViewSeat.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
                containerViewSeat.backgroundColor = UIColor(named: "color_accent") ?? UIColor.blue
                currentState = .SELECTED
            case .text:
                lblSeat.text = seat.symbol
                lblSeat.textColor = .black
                currentState = .text
                containerViewSeat.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            default: break
            }
        }
        
    }

}
