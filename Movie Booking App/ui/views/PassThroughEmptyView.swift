//
//  PassThroughEmptyView.swift
//  Movie Booking App
//
//  Created by Harry Jason on 29/07/2021.
//

import Foundation
import UIKit

class PassThroughEmptyView : UIView {
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

           for v in subviews {

               let ptInSub = v.convert(point, from: v.superview)
               if v.bounds.contains(ptInSub) {
                   return true
               }

           }

           return true

    }
}
