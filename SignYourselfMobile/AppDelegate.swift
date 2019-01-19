//
//  AppDelegate.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 11/29/16.
//  Copyright © 2016 SignYourself. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initializeApp()
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
    {
        return true
    }
    
    //Custom
    
    func initializeApp() {
        AppHelper.shared.loadDependencies()
        RadarManager.shared.loadDefaults()
        configureAppDefaults()
    }
    
    func configureAppDefaults() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
}

