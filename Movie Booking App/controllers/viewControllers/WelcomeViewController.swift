//
//  WelcomeViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 04/06/2021.
//

import Foundation
import UIKit
class WelcomeViewController : BaseViewController {
    
    @IBOutlet weak var btnGetStarted: UIButton!
 
    
    @IBAction func didTapGetStarted(_ sender: Any) {
        navigateToAuthenticationScreen()
//        navigateToMainScreen()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingDialog()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let authToken = UserPreference.authToken
        if authToken != nil {
            navigateToMainScreen()
        }
    }
    
    private func setupViews(){
        setupGetStartedButton()
    }
    
    private func setupGetStartedButton(){
        btnGetStarted.layer.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        btnGetStarted.layer.borderWidth = CGFloat(1)
        btnGetStarted.layer.cornerRadius =  5
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
