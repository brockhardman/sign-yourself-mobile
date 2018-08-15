//
//  SignYourselfProjectAPI.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/17/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

extension SignYourselfAPIClient {
    
    func getProjects(ownerID : String, completionHandlerAPI: @escaping CompletionHandlerAPI) {
        
        let url = Constants.baseRestURL + String(format:Constants.projectListAPI, ownerID)
        let task = SignYourselfAPIClient.shared.defaultSession().dataTask(with: URL(string:url)!, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                let errorType : ErrorType = SignYourselfAPIClient.shared.getErrorType(error: error!)
                completionHandlerAPI(Result.Failure(errorType))
            }
            if (data != nil) {
                do {
                    let project = try JSONDecoder().decode([Project].self, from: data!)
                    completionHandlerAPI(Result.Success(project))
                } catch {
                    debugPrint("JSON Serialization Error")
                }
            }
        })
        task.resume()
    }
}

