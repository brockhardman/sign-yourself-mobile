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
    
    func defaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": SignYourselfAPIManager.shared.accessToken]
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func getErrorType(error : Error) -> ErrorType {
        if (error.localizedDescription.debugDescription.range(of: "401") != nil) {
            return .AuthenticationFailure
        }
        
        return .Unknown
    }
}
