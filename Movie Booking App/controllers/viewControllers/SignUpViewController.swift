//
//  SignUpViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 06/06/2021.
//

import Foundation
import UIKit
class SignUpViewController : BaseViewController {
    
    @IBOutlet weak var btnSignUpWithFacebook: UIButton!
    @IBOutlet weak var btnSignUpWithGoogle: UIButton!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var etPhone: UITextField!
    @IBOutlet weak var etName: UITextField!
    @IBAction func onTapContinue(_ sender: Any) {
        let name = etName.text ?? ""
        let phoneNo = etPhone.text ?? ""
        let emailAddress = etEmail.text ?? ""
        let password = etPassword.text ?? ""
        
        if validateInput(name: name, phoneNo: phoneNo, email: emailAddress, password: password) {
            self.showLoadingDialog(message: "Registering...")
            networkAgent.registerWithEmail(name: name, email: emailAddress, phone: phoneNo, password: password) { result in
                switch result {
                case .success(_):
                    self.dismissDialog()
                    self.showAlertDialog(title: "Account Created", message: "We've successfully created your account. You can enjoy our app now.", buttonText: "Get Started")
                    {
                        self.navigateToMainScreen()
                    }
                case .failure(let errorMessage):
                    self.dismissDialog()
                    self.showErrorDialog(message: errorMessage)
                }
            }
        } else {
            self.showErrorDialog(message: "Please fill all the required fields")
        }
    }
    
    @IBAction func onTapRegisterWithGmail(_ sender: Any) {
        let name = etName.text ?? ""
        let phoneNo = etPhone.text ?? ""
        let emailAddress = etEmail.text ?? ""
        let password = etPassword.text ?? ""
        
        if validateInput(name: name, phoneNo: phoneNo, email: emailAddress, password: password) {
            self.showLoadingDialog(message: "Registering with Google...")
            networkAgent.registerWithGoogle(viewController: self, name: name, email: emailAddress, phone: phoneNo, password: password) { response in
                switch response {
                case .success(_):
                    self.dismissDialog()
                    self.showAlertDialog(title: "Account Created", message: "We've successfully created your account. You can enjoy our app now.", buttonText: "Get Started")
                    {
                        self.navigateToMainScreen()
                    }
                case .failure(let errorMessage):
                    self.dismissDialog()
                    self.showErrorDialog(message: errorMessage)
                }
            }
        } else {
            self.showErrorDialog(message: "Please fill all the required fields")
        }
    }
    
    @IBAction func onTapRegisterWithFacebook(_ sender: Any) {
        let name = etName.text ?? ""
        let phoneNo = etPhone.text ?? ""
        let emailAddress = etEmail.text ?? ""
        let password = etPassword.text ?? ""
        
        if validateInput(name: name, phoneNo: phoneNo, email: emailAddress, password: password) {
            let facebookAuth = FacebookAuth()
            facebookAuth.start(vc: self) { profileResponse in
                self.showLoadingDialog()
                self.networkAgent.registerWithFacebook(accessToken: profileResponse.id, name: name, email: emailAddress, phone: phoneNo, password: password) { response in
                    switch response{
                    case .success(_):
                        self.dismissDialog()
                        self.showAlertDialog(title: "Account Created", message: "We've successfully created your account. You can enjoy our app now.", buttonText: "Get Started")
                        {
                            self.navigateToMainScreen()
                        }
                    case .failure(let errorMessage):
                        self.dismissDialog()
                        self.showErrorDialog(message: errorMessage)
                    }
                }
            } failure: { errorMessage in
                self.showErrorDialog(message: errorMessage)
            }

        } else {
            self.showErrorDialog(message: "Please fill all the required fields")
        }
        
    }
    
    private func validateInput(name : String , phoneNo : String , email : String , password : String) -> Bool {
        return !name.isEmpty && !phoneNo.isEmpty && email.isValidEmail() && !password.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func setupTextFields(){
        etPassword.autocorrectionType = .no
        etEmail.useUnderline()
        etPassword.useUnderline()
        etPhone.useUnderline()
        etName.useUnderline()
        btnSignUpWithGoogle.layer.borderWidth = CGFloat(0.6)
        btnSignUpWithGoogle.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSignUpWithGoogle.layer.cornerRadius = 7
        btnSignUpWithFacebook.layer.borderWidth = CGFloat(0.6)
        btnSignUpWithFacebook.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        btnSignUpWithFacebook.layer.cornerRadius = 7
    }
}
