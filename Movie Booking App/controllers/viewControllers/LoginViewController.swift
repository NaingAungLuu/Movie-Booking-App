//
//  LoginViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import UIKit
import GoogleSignIn

class LoginViewContrller : BaseViewController {
    
    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var btnSignInWithFacebook: UIButton!
    @IBOutlet weak var btnSignInWithGoogle: UIButton!
    @IBOutlet weak var etPassword: UITextField!
    @IBAction func onTapContinue(_ sender: Any) {
        
        let userEmail : String = etEmail.text ?? ""
        let userPassword : String = etPassword.text ?? ""
        
        if validateInput(userEmail, userPassword) {
            self.showLoadingDialog(message: "Logging in...")
            networkAgent.login(email : userEmail , password: userPassword) { userVO in
                self.dismissDialog()
                self.navigateToMainScreen()
            } onFailure: { error in
                self.dismissDialog()
                self.showErrorDialog(title: "Error", message: error)
            }

        } else {
            self.showErrorDialog(title: "Warning!", message: "Please enter your credentials correctly.")
        }
    
    }
    
    private func validateInput(_ userEmail : String ,_ userPassword : String) -> Bool {
        return !userEmail.isEmpty && !userPassword.isEmpty && userEmail.isValidEmail()
    }
    @IBAction func onTapSignInWithGoogle(_ sender: Any) {
        showLoadingDialog(message: "Logging in...")
        networkAgent.loginWithGoogle(controller: self) {
            self.dismissDialog()
            self.navigateToMainScreen()
        }
        onFailure : { errorMessage in
            self.dismissDialog()
            self.showErrorDialog(message: errorMessage)
        }

    }
    @IBAction func onTapSignInWithFacebook(_ sender: Any) {
        let facebookAuth = FacebookAuth()
        self.showLoadingDialog(message: "Logging in...")
        facebookAuth.start(vc: self) { profileResponse in
            
            //Just for fun
            let message = """
            ==================================
            Facebook Login Successful
            ==================================
            Token - \(profileResponse.token)
            Email - \(profileResponse.email)
            Profile - \(profileResponse.profilePic)
            Name - \(profileResponse.name)
            """
            print(message)
            
            self.networkAgent.loginWithFacebook(accessToken: profileResponse.id) {
                self.dismissDialog()
                self.navigateToMainScreen()
            } onFailure: { errorMessage in
                self.dismissDialog()
                self.showErrorDialog(message: errorMessage)
            }

        } failure: { error in
            print("Facebook login eror - \(error)")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: etEmail.frame.height - 1, width: etEmail.frame.width, height: 1.0)
//        bottomLine.backgroundColor = UIColor.white.cgColor
//        etEmail.borderStyle = UITextField.BorderStyle.none
//        etEmail.layer.addSublayer(bottomLine)
        
        etEmail.useUnderline()
        etPassword.useUnderline()
        btnSignInWithFacebook.layer.borderWidth = CGFloat(0.6)
        btnSignInWithFacebook.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSignInWithFacebook.layer.cornerRadius = 7
        btnSignInWithGoogle.layer.borderWidth = CGFloat(0.6)
        btnSignInWithGoogle.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSignInWithGoogle.layer.cornerRadius = 7
    }
}
