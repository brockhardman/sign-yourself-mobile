//
//  ActiveControllersService.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/26/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import Foundation

typealias ControllersCompletionHandler = (_ controllers:Array<Any>) -> Void

class ActiveControllerService: NSObject {
    
    public func configureWithURL(url: String, completionBlock: @escaping ControllersCompletionHandler) {
        if (url.isEmpty)
        {
            configureWithJSONFile(jsonFile: Constants.activeControllersFileName, completion: completionBlock)
        }
        else
        {
            configureWithExternalURL(url: url, completion: completionBlock)
        }
    }

    private func configureWithExternalURL(url:String, completion:@escaping ControllersCompletionHandler) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if (error != nil) {
                completion([])
            } else {
                let json = try? JSONSerialization.jsonObject(with: data! as Data, options: [])
                let sortedJson = (json as! NSDictionary).sorted(by: {($0.key as! String) < ($1.key as! String)})
                completion(Array(sortedJson.map{$0.value}))
            }
        })
        task.resume()
    }
    
    private func configureWithJSONFile(jsonFile:String, completion:@escaping ControllersCompletionHandler) {
        let filePath = Bundle.main.path(forResource: jsonFile, ofType: "json")
        let data = NSData(contentsOfFile: filePath!)
        let json = try? JSONSerialization.jsonObject(with: data! as Data, options: [])
        let sortedJson = (json as! NSDictionary).sorted(by: {($0.key as! String) < ($1.key as! String)})
        completion(Array(sortedJson.map{$0.value}))
    }
}
