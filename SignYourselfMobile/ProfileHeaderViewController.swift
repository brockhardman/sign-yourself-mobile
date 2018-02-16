//
//  ProfileHeaderViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 7/29/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import UIKit

class ProfileHeaderViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var joinedOnLabel: UILabel!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setRounded(borderWidth: 5, borderColor: .white)
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    @objc func didLogin() {
        joinedOnLabel.text = "Joined on: \(SignYourselfAPIManager.shared.profileData?.created_at ?? "")"
        firstNameLabel.text = SignYourselfAPIManager.shared.profileData?.first_name
        lastNameLabel.text = SignYourselfAPIManager.shared.profileData?.last_name
        locationLabel.text = (SignYourselfAPIManager.shared.profileData?.state_province ?? "") + ", " + (SignYourselfAPIManager.shared.profileData?.country ?? "")
    }
}
