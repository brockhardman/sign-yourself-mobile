//
//  WePayManager.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/18/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class WePayManager : NSObject {
    
    static let shared : WePayManager = WePayManager()
    var wePay : WePay?
    
    override init() {
        super.init()
        
        let config : WPConfig = WPConfig.init(clientId: Constants.wepayClientId, environment: Constants.wepayEnvironment)
        config.useLocation = true
        wePay = WePay.init(config: config)
    }

}
