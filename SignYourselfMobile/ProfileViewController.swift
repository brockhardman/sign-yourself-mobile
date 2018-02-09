//
//  ProfileViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/22/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import SwiftyJSON

class ProfileViewController: ActiveViewController {
    
    var profileData : Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenBackgroundColor
        
        loadProfileData()
    }
    
    private func loadProfileData() {
        SignYourselfAPIClient.shared.getProfileData(profileID: "22") { result in
            
            switch result {
            case .Success(let profile):
                self.profileData = profile as? Profile
            case .Failure(let error):
                debugPrint(error)
            }
        }
    }
}
