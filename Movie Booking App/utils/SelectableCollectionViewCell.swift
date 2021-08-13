//
//  SelectableCollectionViewCell.swift
//  Movie Booking App
//
//  Created by Harry Jason on 04/08/2021.
//

import Foundation
import UIKit

class SelectableCollectionViewCell : UICollectionViewCell {
   
    var currentState : State = .UNSELECTED {
        didSet {
            onUpdateState(currentState)
        }
    }
    
    func onUpdateState(_ state: State) {
        switch currentState {
        case .SELECTED :
            onSelected()
        case .UNSELECTED :
            onDeselected()
        }
    }
    
    func onSelected() {}
    func onDeselected(){}
    
}

enum State {
    case SELECTED
    case UNSELECTED
}
