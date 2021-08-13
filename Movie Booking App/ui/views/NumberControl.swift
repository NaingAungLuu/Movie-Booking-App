//
//  NumberControl.swift
//  Movie Booking App
//
//  Created by Harry Jason on 13/06/2021.
//

import Foundation
import UIKit
@IBDesignable class NumberControl : UIView{
    
    @IBOutlet weak var containerControl: UIStackView!
    
    var onNumberChange : ((Int) -> Void)?
    
    @IBInspectable var value : Int = 0
    {
        didSet{
            lblCount.text = String(value)
            onNumberChange?(value)
        }
    }
    
    @IBOutlet weak var lblCount: UILabel!
    @IBAction func onTapAdd(_ sender: Any) {
        value += 1
    }
    @IBAction func onTapRemove(_ sender: UIButton) {
        value = max(value - 1 , 0)
    }
    
    var view: UIView!
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        loadViewFromNib()
    }
    override init(frame: CGRect) {
       super.init(frame: frame)
        loadViewFromNib()
    }
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
        initView()
    }
    
    func initView(){
        containerControl.layer.borderWidth = CGFloat(1.0)
        containerControl.layer.borderColor = UIColor(named: "color_seat_taken")?.cgColor
        containerControl.layer.cornerRadius = 10
        
    }
    
    @objc func increaseCount(){
        value += 1
    }
    
    @objc func decreaseCount(){
        value -= 1
    }
    
}
