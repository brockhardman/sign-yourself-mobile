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
import Alamofire
import SwiftyJSON
import Kingfisher
import TwitterKit

var config = [String: Any]()

class AppBootstrapper {
    
    func bootstrap() {
        setupConfiguration()
    }
    
    func setupConfiguration() {
        parseConfiguration(fileName: Constants.configFileName)
        if Constants.isDebug {
            runFacebookTests()
            runAlamofireTests()
            runGoogleTests()
            runTwitterTests()
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
    
    func runAlamofireTests() {
        
        //Examples can be found at https://github.com/Alamofire/Alamofire
        //Examples can be found at https://github.com/SwiftyJSON/SwiftyJSON
        //Examples can be found at https://jsonplaceholder.typicode.com/
        
        Alamofire.request(Constants.testDataUrl, method: .get).validate().responseData { response in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    let dataString = String(data: data, encoding: .utf8)
                    debugPrint("DataString: \(String(describing: dataString))")
                    debugPrint("Data: \(data)")
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
        
        Alamofire.request(Constants.testJSONUrl, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                debugPrint("JSON: \(json)")
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func runGoogleTests() {
        
        //Examples can be found at https://developers.google.com/analytics/devguides/collection/ios/v3/?ver=swift
        
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: Constants.testGoogleTracking)
        
        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    func runTwitterTests() {
        TWTRAPIClient().loadTweet(withID: Constants.testTweetId) { (tweet, error) in
            debugPrint("Tweet: \(String(describing: tweet?.text))")
        }
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
