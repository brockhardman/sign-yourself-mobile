//
//  NSDictionary+SYS.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/26/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

extension NSDictionary {
    @nonobjc public class func getValuesFromDictionary(dictionary: NSDictionary) -> NSArray {
        if (dictionary.count > 0)
        {
            let mutableObject = NSMutableArray()
            let keys : Array = dictionary.allKeys
            
            for key in keys {
                mutableObject.add(dictionary.value(forKey: key as! String) as! [String: AnyObject])
            }
            
            return mutableObject
        }
        
        return [];
    }
}

