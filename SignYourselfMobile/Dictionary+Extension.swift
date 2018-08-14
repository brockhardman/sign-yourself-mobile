//
//  Dictionary+Extension.swift
//  Reliant 
//
//  Created by Woodall, Kristopher on 5/19/16.
//  Copyright © 2016 Woodall, Kristopher. All rights reserved.
//

import Foundation


extension Dictionary {
    
    func stringValueOrNil(_ key: Key) -> String? {
        
        guard let string = self[key] as? String, string != "" else {
            return nil;
        }
        
        return string
    }
    
    func selectorOrNil(_ key: Key) -> Selector? {
        
        guard let string = stringValueOrNil(key) else {
            return nil
        }
        
        return Selector(string)
    }
    
    /// Creates a Plist from Dictionary values
    var plist: Data? {
        do {
            return try PropertyListSerialization.data(fromPropertyList: self, format: PropertyListSerialization.PropertyListFormat.xml, options: 0)
        } catch  {
            return nil
        }
    }
    
    /// Creates a JSON from Dictionary Values
    var json: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            
        } catch {
            return nil
        }
    }
}
