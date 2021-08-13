//
//  BaseViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {
    
    var alertDialog : UIAlertController? = nil
    
    func showAlertDialog(title : String? = "" , message body: String, buttonText : String = "OK", onClick: (()-> Void)? = nil) {
        alertDialog = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alertDialog?.addAction(UIAlertAction(title: buttonText, style: .default, handler: { alertAction in
            onClick?()
        }))
        self.present(alertDialog!, animated: true)
    }
    
    func showErrorDialog(title : String? = "Error" , message body: String, buttonText : String = "OK") {
        alertDialog = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alertDialog?.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
        self.present(alertDialog!, animated: true)
    }
    
    func showLoadingDialog(message : String = "Loading...") {
        alertDialog = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();

        alertDialog?.view.addSubview(loadingIndicator)
        self.present(alertDialog!, animated: false, completion: nil)
    }
    
    func dismissDialog(){
        alertDialog?.dismiss(animated: false, completion: nil)
    }
    
    
}
