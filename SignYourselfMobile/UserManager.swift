//
//  UserManager.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class UserManager {
    
    static let shared : UserManager = UserManager()
    var profileData : Profile?
    var accessToken : String = ""
    var currentUser : User? 
    
    func userIsLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKeys.loggedInKey)
    }
    
    func logout() {
        profileData = nil
        currentUser = nil
        accessToken = ""
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.loggedInKey)
        NotificationCenter.default.post(name: NSNotification.Name(Constants.signInNeededNotification), object: nil)
    }
}
