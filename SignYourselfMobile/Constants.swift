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
    #else
        static let isDebug = false
    #endif
    static let testJSONUrl = "https://jsonplaceholder.typicode.com/posts/1"
    static let testDataUrl = "https://www.google.com"
    static let testImageUrl = "https://image.s4.exct.net/lib/fe9f15707567057e7d/m/1/christmas-email_01.png"
    static let testGoogleTracking = "Google Tracking test"
    static let testTweetId = "824695931677274112"
    static let configFileName = "Configuration"
}
