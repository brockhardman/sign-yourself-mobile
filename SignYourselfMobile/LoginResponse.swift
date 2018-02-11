//
//  LoginResponse.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

struct LoginResponse : Codable {
    var userName : String?
    var user : User?
    var accessToken : String?
}
