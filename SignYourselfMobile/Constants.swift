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
        static let baseRestURL = "https://sy-api-prod.herokuapp.com/site/v1"
    #endif
    
    static let testImageUrl = "https://image.s4.exct.net/lib/fe9f15707567057e7d/m/1/christmas-email_01.png"
    static let configFileName = "Configuration"
    static let activeControllersFileName = "activeViewControllers"
    
    //NOTIFICATIONS
    static let userDidLoginNotification = "userDidLoginNotification"
    static let userDidRegisterNotification = "userDidRegisterNotification"
    
    //APIs
    static let profileAPI = "/profile?user_id=%@"
    static let loginAPI = "/user/login"
    static let registerAPI = "/user/register"
    static let eventListAPI = "/event/list?author_id=%@"
    static let projectListAPI = "/project/list?owner_id=%@"
}
