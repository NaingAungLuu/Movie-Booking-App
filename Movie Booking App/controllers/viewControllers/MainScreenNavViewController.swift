//
//  MainScreenNavViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 22/07/2021.
//

import Foundation
import UIKit
class MainScreenNavViewController : UINavigationController {
    override func viewDidLoad() {
    }
}

extension MainScreenNavViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
