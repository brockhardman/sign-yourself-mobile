//
//  SignYourselfLoginAPI.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

extension SignYourselfAPIClient {
    
    func login(username : String, password : String, completionHandlerAPI: @escaping CompletionHandlerAPI) {
        
        let url = Constants.baseRestURL + Constants.loginAPI
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameterDictionary = ["username" : username, "password" : password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        let task = SignYourselfAPIClient.shared.defaultSession().dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                let errorType : ErrorType = SignYourselfAPIClient.shared.getErrorType(error: error!)
                completionHandlerAPI(Result.Failure(errorType))
            }
            if (data != nil) {
                do {
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data!)
                    completionHandlerAPI(Result.Success(response))
                } catch {
                    debugPrint("JSON Serialization Error")
                }
            }
        })
        task.resume()
    }
    
    func register(email: String, username : String, password : String, verifyPassword: String, toc: Bool, completionHandlerAPI: @escaping CompletionHandlerAPI) {
        
        let url = Constants.baseRestURL + Constants.registerAPI
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameterDictionary = ["email" : email, "username" : username, "password" : password, "verifyPassword" : verifyPassword, "toc" : toc] as [String : Any]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        let task = SignYourselfAPIClient.shared.defaultSession().dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if (error != nil) {
                let errorType : ErrorType = SignYourselfAPIClient.shared.getErrorType(error: error!)
                completionHandlerAPI(Result.Failure(errorType))
            }
            if (data != nil) {
                do {
                    let response = try JSONDecoder().decode(RegisterResponse.self, from: data!)
                    if response.success! {
                        completionHandlerAPI(Result.Success(response))
                    } else {
                        completionHandlerAPI(Result.Errors(response.errors!))
                    }
                } catch {
                    debugPrint("JSON Serialization Error")
                }
            }
        })
        task.resume()
    }
}
