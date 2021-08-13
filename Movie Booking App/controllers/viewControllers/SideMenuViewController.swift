//
//  SideMenuViewController.swift
//  Movie Booking App
//
//  Created by Harry Jason on 23/07/2021.
//

import Foundation
import UIKit
import SDWebImage

class SideMenuViewController : BaseViewController {
    
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var btnLogOut: UIStackView!
    
    override func viewDidLoad() {
        setupListeners()
        setupProfileData()
    }
    
    private func setupProfileData() {
        let userVO = UserPreference.userVO
        
        let profileImageUrl = MovieAppURL.image(path: userVO?.profileImage).asImageURL()
        ivProfile.sd_setImage(with: profileImageUrl , placeholderImage: UIImage(named: "img_profile"))
        
        lblName.text = userVO?.name ?? ""
        lblEmailAddress.text = userVO?.email ?? ""
    }
    
    private func setupListeners() {
        btnLogOut.isUserInteractionEnabled = true
        let btnLogOutTapListener = UITapGestureRecognizer(target: self, action: #selector(onTapLogOut))
        btnLogOut.addGestureRecognizer(btnLogOutTapListener)
    }
    
    @objc func onTapLogOut() {
        showLoadingDialog(message: "Logging Out...")
        networkAgent.logOut {
            self.dismissDialog()
            self.navigateToAuthenticationScreen()
        }
    }
    
}
