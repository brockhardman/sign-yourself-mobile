//
//  SignYourselfAPIManager.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class SignYourselfAPIManager : NSObject {
    
    static let shared : SignYourselfAPIManager = SignYourselfAPIManager()
    var profileData : Profile?
    var currentUser : User?
    var accessToken : String = ""
    
    func loadProfileData(completion: @escaping () -> Void) {
        
        guard currentUser?.id != nil else {
            return
        }
        
        SignYourselfAPIClient.shared.getProfileData(profileID: (currentUser?.id)!) { result in
            
            switch result {
            case .Success(let profile):
                self.profileData = profile as? Profile
                completion()
            case .Errors(let errors):
                debugPrint(errors)
            case .Failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func logout() {
        profileData = nil
        currentUser = nil
        accessToken = ""
    }
}
