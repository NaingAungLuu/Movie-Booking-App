//
//  PassThroughScrollView.swift
//  Movie Booking App
//
//  Created by Harry Jason on 29/07/2021.
//


import UIKit

class PassThruScrollView: UIScrollView {
    
    var passThruViewRef: UIView?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return point.y > passThruViewRef?.frame.height ?? 0
    }
    
}
