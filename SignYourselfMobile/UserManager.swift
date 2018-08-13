//
//  UserManager.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class UserManager {
    static let shared : UserManager = UserManager()
    
    func userIsLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKeys.loggedInKey)
    }
}
