//
//  AppHelper.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/13/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation
import Fabric
import Crashlytics

public enum EnvironmentBuildType: String {
    case QA
    case Prod
}

/*
 * This class is used for app specific helper functions
 */

class AppHelper {
    
    public static var shared = AppHelper()
    public var buildType : EnvironmentBuildType = .QA
    public var baseURL : URL?
    
    /*
     * Call this function to load all globally used app dependencies
     */
    public func loadDependencies() {
        setLocalVariables()
        setURLCache()
        loadFabric()
    }
    
    private func setLocalVariables() {
        if let build = Bundle(for: AppHelper.self).infoDictionary?[AppStrings.BuildTypeKey] as? String {
            self.buildType = EnvironmentBuildType(rawValue: build)!
        }
        
        if let endPoints = Bundle(for: AppHelper.self).infoDictionary?[AppStrings.BaseURLEndpointKeys].Dictionary {
            if let url = endPoints[self.buildType.rawValue].String {
                self.baseURL = URL(string: url)
            }
        }
    }
    
    private func loadFabric() {
        Crashlytics.sharedInstance().setUserName(UIDevice.current.name)
        Fabric.with([Crashlytics.self])
    }
    
    private func setURLCache() {
        let cacheSizeMemory: Int = 4*1024*1024 // 4MB
        let cacheSizeDisk:Int = 32*1024*1024 // 32MB
        URLCache.shared = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: nil)
    }
}

