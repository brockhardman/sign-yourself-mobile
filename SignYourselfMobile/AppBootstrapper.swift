//
//  AppBootstrapper.swift
//  iOSTemplate
//
//  Created by Brock Hardman on 1/24/17.
//  Copyright © 2017 Credera. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

var config = [String: Any]()

class AppBootstrapper {
    
    func bootstrap() {
        setupConfiguration()
    }
    
    func setupConfiguration() {
        parseConfiguration(fileName: Constants.configFileName)
        if Constants.isDebug {
            
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
}
