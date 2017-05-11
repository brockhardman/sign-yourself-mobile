//
//  ActiveControllersService.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/26/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ controllers:Array<Any>) -> Void

class ActiveControllerService: NSObject {
    
    public func configureWithURL(url: String, completionBlock: @escaping CompletionHandler) {
        if (url.isEmpty)
        {
            configureWithJSONFile(jsonFile: Constants.activeControllersFileName, completion: completionBlock)
        }
        else
        {
            configureWithExternalURL(url: url, completion: completionBlock)
        }
    }

    private func configureWithExternalURL(url:String, completion:@escaping CompletionHandler) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) in
            if (error != nil) {
                completion([])
            } else {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                let controllers = NSDictionary.getValuesFromDictionary(dictionary: json as! NSDictionary);
                completion(controllers as! Array<Any>);
            }
        })
        task.resume()
    }
    
    private func configureWithJSONFile(jsonFile:String, completion:@escaping CompletionHandler) {
        let filePath = Bundle.main.path(forResource: jsonFile, ofType: "json")
        let data = NSData(contentsOfFile: filePath!)
        let json = try? JSONSerialization.jsonObject(with: data! as Data, options: [])
        let controllers = NSDictionary.getValuesFromDictionary(dictionary: json as! NSDictionary);
        completion(controllers as! Array<NSDictionary>);
    }
}
