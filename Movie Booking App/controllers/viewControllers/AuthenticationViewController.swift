//
//  AuthenticationViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 04/06/2021.
//

import Foundation
import UIKit
class AuthenticationViewController : UIViewController{
    
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var indicatorLogin: UIView!
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var indicatorSignUp: UIView!
    @IBOutlet weak var tabLogin: UIView!
    @IBOutlet weak var tabSignUp: UIView!
    
    var pageViewController : AuthenticationPageController?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupListeners()
    }
    
    private func setupListeners(){
        let loginTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapLogin))
        let signUpTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapSignUp))
        tabLogin.isUserInteractionEnabled = true
        tabSignUp.isUserInteractionEnabled = true
        tabLogin.addGestureRecognizer(loginTapGesture)
        tabSignUp.addGestureRecognizer(signUpTapGesture)
    }
    
    @objc func onTapLogin() {
        pageViewController?.navigateToPage(pageNo: 0)
    }
    
    @objc func onTapSignUp() {
        pageViewController?.navigateToPage(pageNo: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        pageViewController = destination as? AuthenticationPageController
        if let pageController = destination as? AuthenticationPageController {
            pageController.onSwipeDelegate = { pageNo in
                if pageController.currentPage != pageNo {
                    if(pageNo == 0){
                        self.indicatorSignUp.isHidden = true
                        self.indicatorLogin.isHidden = false
                        let selectedTextColor = self.lblLogin.textColor
                        self.lblLogin.textColor = self.lblSignUp.textColor
                        self.lblSignUp.textColor = selectedTextColor
                    }else {
                        self.indicatorSignUp.isHidden = false
                        self.indicatorLogin.isHidden = true
                        let selectedTextColor = self.lblLogin.textColor
                        self.lblLogin.textColor = self.lblSignUp.textColor
                        self.lblSignUp.textColor = selectedTextColor
                    }
                }
            }
          }
    }
}
