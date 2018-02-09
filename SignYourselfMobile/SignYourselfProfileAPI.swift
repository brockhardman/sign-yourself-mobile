//
//  SignYourselfProfileAPI.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/8/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

extension SignYourselfAPIClient {
    
    func getProfileData(profileID : String, completionHandler: @escaping CompletionHandlerAPI) {
        
        let url = Constants.baseRestURL + String(format:Constants.profileAPI, profileID)
        let task = SignYourselfAPIClient.shared.defaultSession().dataTask(with: URL(string:url)!, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                completionHandler(Result.Failure(error!))
            }
            if (data != nil) {
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data!)
                    completionHandler(Result.Success(profile))
                } catch {
                   debugPrint("JSON Serialization Error")
                }
            }
        })
        task.resume()
    }
}
