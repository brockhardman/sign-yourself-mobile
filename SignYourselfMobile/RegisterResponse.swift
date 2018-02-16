//
//  RegisterResponse.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

struct RegisterResponse : Codable {
    var success : Bool?
    var errors : [String : [String]]?
}
