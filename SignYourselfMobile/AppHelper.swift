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
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterPush

public enum EnvironmentBuildType: String {
    case QA
    case Prod
}

/*
 * This class is used for app specific helper functions
 */

class AppHelper {
    
    static var shared = AppHelper()
    var buildType : EnvironmentBuildType = .QA
    var baseURL : URL?
    var config = [String: Any]()
    
    /*
     * Call this function to load all globally used app dependencies
     */
    public func loadDependencies() {
        setLocalVariables()
        setURLCache()
        loadFabric()
        loadAppCenter()
        setupConfiguration()
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
    
    private func loadAppCenter() {
        MSAppCenter.start("5553af16-6d67-404f-bcc5-cde039d16d0e", withServices:[ MSAnalytics.self, MSCrashes.self, MSPush.self ])
    }
    
    private func setURLCache() {
        let cacheSizeMemory: Int = 4*1024*1024 // 4MB
        let cacheSizeDisk:Int = 32*1024*1024 // 32MB
        URLCache.shared = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: nil)
    }
    
    private func setupConfiguration() {
        //TODO: Put all configuration entries into filename at location in constant
        parseConfiguration(fileName: Constants.configFileName)
        if Constants.isDebug {
            
        }
    }
    
    private func parseConfiguration(fileName : String) {
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                config = result!;
            }
        }
    }
}

