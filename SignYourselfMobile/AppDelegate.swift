//
//  AppDelegate.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 11/29/16.
//  Copyright © 2016 SignYourself. All rights reserved.
//

import UIKit
import RadarSDK
import FacebookCore
import Fabric
import Crashlytics
import Google
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /**************
         Radar
         ***************/
        
        Radar.initialize(publishableKey: "org_test_pk_5b2fbea6486e6d94da5b1b6e7fce86f0f4e7ae0e")
        Radar.setUserId("BrockTest")
        Radar.setDescription("Testing, duh")
        
        let status = Radar.authorizationStatus()
        if (status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse) {
            Radar.trackOnce(completionHandler: { (status: RadarStatus, location: CLLocation?, events: [RadarEvent]?, user: RadarUser?) in
                if (status == RadarStatus.success) {
                    debugPrint(user?.userId as Any)
                    debugPrint(location?.coordinate as Any)
                } else {
                    debugPrint(status);
                }
            })
        } else {
            Radar.requestWhenInUseAuthorization()
        }
        
        initializeApp()
        
        return SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    //Custom
    
    func initializeApp() {
        configureFabric()
        configureFirebase()
        bootstrapServices()
    }
    
    func configureFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    func configureFirebase() {
        FIRApp.configure()
    }
    
    func bootstrapServices() {
        //Bootstrap application for startup
        let bootstrapper = AppBootstrapper()
        bootstrapper.bootstrap()
    }
}

