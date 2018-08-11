//
//  SignYourselfProfileAPI.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/8/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

extension SignYourselfAPIClient {
    
    func getProfileData(profileID : String, completionHandlerAPI: @escaping CompletionHandlerAPI) {
        
        let url = Constants.baseRestURL + String(format:Constants.profileAPI, profileID)
        print(url)
        let task = SignYourselfAPIClient.shared.defaultSession().dataTask(with: URL(string:url)!, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                let errorType : ErrorType = SignYourselfAPIClient.shared.getErrorType(error: error!)
                completionHandlerAPI(Result.Failure(errorType))
            }
            if (data != nil) {
                do {
                    let profile = try JSONSerialization.jsonObject(with: data!, options: [])
                    //let profile = try JSONDecoder().decode(Profile.self, from: data!)
                    print(profile)
                    completionHandlerAPI(Result.Success(profile))
                } catch {
                   debugPrint("JSON Serialization Error")
                }
            }
        })
        task.resume()
    }
}
