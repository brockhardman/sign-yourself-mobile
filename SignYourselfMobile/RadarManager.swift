//
//  LocationManager.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import RadarSDK
import CoreLocation

/**************
 Radar
 ***************/

class RadarManager : NSObject, RadarDelegate {
    
    public static let shared : RadarManager = RadarManager()
    
    public func loadDefaults() {
        Radar.setDelegate(self)
        Radar.initialize(publishableKey: "org_test_pk_5b2fbea6486e6d94da5b1b6e7fce86f0f4e7ae0e")
        Radar.setUserId("BrockTest")
        Radar.setDescription("Testing, duh")
        Radar.setPlacesProvider(.facebook)
    }
    
    func didReceiveEvents(_ events: [RadarEvent], user: RadarUser) {
        // do something with events, user
    }
    
    func didUpdateLocation(_ location: CLLocation, user: RadarUser) {
        // do something with location, user
    }
    
    func didFail(status: RadarStatus) {
        // do something with status
    }
}
