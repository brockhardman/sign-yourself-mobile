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
import TwitterKit
import Google

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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }
    
    //Custom
    
    func initializeApp() {
        configureFabric()
        configureGoogle()
        bootstrapServices()
    }
    
    func configureFabric() {
        //Fabric
        Fabric.with([Crashlytics.self, Twitter.self])
    }
    
    func configureGoogle() {
        // Configure tracker from GoogleService-Info.plist.
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        // Optional: configure GAI options.
        guard let gai = GAI.sharedInstance() else {
            assert(false, "Google Analytics not configured correctly")
        }
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
        if Constants.isDebug {
            gai.logger.logLevel = GAILogLevel.verbose
        } else {
            gai.logger.logLevel = GAILogLevel.error
        }
    }
    
    func bootstrapServices() {
        //Bootstrap application for startup
        let bootstrapper = AppBootstrapper()
        bootstrapper.bootstrap()
    }
}

