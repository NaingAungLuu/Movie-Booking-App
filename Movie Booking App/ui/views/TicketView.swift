//
//  TicketView.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import UIKit
class TicketView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
        layer.cornerRadius = 18
    }
    
    required init?(coder: NSCoder) {
        fatalError("No storyboard here")
    }
}
