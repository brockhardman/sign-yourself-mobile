//
//  SignYourselfAPIManager.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class SignYourselfAPIManager : NSObject {
    
    static let shared : SignYourselfAPIManager = SignYourselfAPIManager()
    
    func loadProfileData(userId: String, completion: @escaping () -> Void) {
        
        guard userId.count != 0 else {
            return
        }
        
        SignYourselfAPIClient.shared.getProfileData(profileID: userId) { result in
            
            switch result {
            case .Success(let profile):
                UserManager.shared.profileData = profile as? Profile
                completion()
            case .Errors(let errors):
                debugPrint(errors)
            case .Failure(let error):
                debugPrint(error)
            }
        }
    }
    
    
}
