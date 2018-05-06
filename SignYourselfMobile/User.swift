//
//  User.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 1/27/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

struct User : Codable {
    var id : String?
    var username : String?
    var password_hash : String?
    var email : String?
    var status : String?
    var toc : String?
    var banned : String?
    var passwordLost : Bool? = false
    var confirmRegistration : String?
    var token : String?
    var artist : String?
    var source : String?
    var featured : String?
    var author_id : String?
    var created_at : String?
    var updated_at : String?
    var projects : [Project]?
    var events : [Event]?
    var roles : [Role]?
}
