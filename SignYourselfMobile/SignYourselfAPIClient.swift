//
//  SignYourselfAPI.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 1/26/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import SwiftyJSON

typealias CompletionHandlerAPI = (Result<Any>) -> Void

enum Result<T:Any> {
    case Success(T)
    case Failure(Error)
}

enum ErrorType: Error {
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
}
