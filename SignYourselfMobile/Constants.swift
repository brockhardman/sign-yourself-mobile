//
//  Constants.swift
//  iOSTemplate
//
//  Created by Brock Hardman on 1/24/17.
//  Copyright © 2017 Credera. All rights reserved.
//

struct Constants {
    //TESTING VALUES
    #if DEBUG
        static let isDebug = true
        static let baseRestURL = "https://sy-api-prod.herokuapp.com/site/v1"
    #else
        static let isDebug = false
    #endif
    
    static let testImageUrl = "https://image.s4.exct.net/lib/fe9f15707567057e7d/m/1/christmas-email_01.png"
    static let configFileName = "Configuration"
    static let activeControllersFileName = "activeViewControllers"
    
    //APIs
    static let profileAPI = "/profile?user_id=%@"
}
