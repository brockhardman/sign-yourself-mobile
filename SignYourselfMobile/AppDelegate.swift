//
//  AppDelegate.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 11/29/16.
//  Copyright © 2016 SignYourself. All rights reserved.
//

import UIKit
import RadarSDK
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initializeApp()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return true
    }
    
    //Custom
    
    func initializeApp() {
        RadarManager.shared.loadDefaults()
        configureFabric()
        bootstrapServices()
    }
    
    func configureFabric() {
        Fabric.with([Crashlytics.self])
    }
    
    func bootstrapServices() {
        //Bootstrap application for startup
        let bootstrapper = AppBootstrapper()
        bootstrapper.bootstrap()
    }
}

