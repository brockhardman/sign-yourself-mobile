//
//  SignYourselfAPI.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 1/26/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

typealias CompletionHandlerAPI = (Result<Any>) -> Void

enum Result<T:Any> {
    case Success(T)
    case Failure(ErrorType)
}

enum ErrorType: Error {
    case Unknown
    case AuthenticationFailure
}

class SignYourselfAPIClient : NSObject {
    
    static let shared : SignYourselfAPIClient = SignYourselfAPIClient()
    var accessToken : String = "adbb4eb8cce17819f000e5df7db1a666"
    
    func defaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": accessToken]
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func getErrorType(error : Error) -> ErrorType {
        if (error.localizedDescription.debugDescription.range(of: "401") != nil) {
            return .AuthenticationFailure
        }
        
        return .Unknown
    }
}
