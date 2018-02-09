//
//  AppBootstrapper.swift
//  iOSTemplate
//
//  Created by Brock Hardman on 1/24/17.
//  Copyright © 2017 Credera. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import SwiftyJSON
import Kingfisher
import Firebase

var config = [String: Any]()

class AppBootstrapper {
    
    func bootstrap() {
        setupConfiguration()
    }
    
    func setupConfiguration() {
        parseConfiguration(fileName: Constants.configFileName)
        if Constants.isDebug {
            runFacebookTests()
            runKingfisherTests()
        }
    }
    
    func parseConfiguration(fileName : String) {
        if let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                config = result!;
                debugPrint("JSON: \(JSON(config))")
            }
        }
    }
    
    func runFacebookTests() {
        AppEventsLogger.log("Application did load - FacebookSDK")
    }
    
    func runKingfisherTests() {
        
        //Examples can be found at https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet
        
        let key = Constants.testImageUrl
        
        ImageCache.default.retrieveImage(forKey: key, options: nil) {
            image, cacheType in
            if let image = image {
                debugPrint("Get image \(image), cacheType: \(cacheType).")
            } else {
                debugPrint("Not exist in cache.")
                ImageDownloader.default.downloadImage(with: URL(string:key)!, options: [], progressBlock: nil) {
                    (image, error, url, data) in
                    debugPrint("Downloaded Image: \(String(describing: image))")
                    if image != nil {
                        ImageCache.default.store(image!, forKey: key)
                    }
                    
                }
            }
        }
    }
}
