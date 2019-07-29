//
//  Optional+Extension.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/13/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import UIKit

/// Extension that converts a any type to a specified type
public extension Optional where Wrapped: Any {
    
    /// Creates String if one
    var String: String? {
        return self as? String
    }
    
    /// Creates URL
    var URL: URL? {
        return self as? URL
    }
    
    /// Creates Int if one
    var Int: Int? {
        return self as? Int
    }
    
    /// Creates Double if one
    var Double: Double? {
        return self as? Double
    }
    
    /// Creates Int8
    var Int8: Int8? {
        return self as? Int8
    }
    
    /// Creates UInt8
    var UInt8: UInt8? {
        return self as? UInt8
    }
    
    /// Creates Int16
    var Int16: Int16? {
        return self as? Int16
    }
    
    /// Creates UInt16
    var UInt16: UInt16? {
        return self as? UInt16
    }
    
    /// Creates Int32
    var Int32: Int32? {
        return self as? Int32
    }
    
    /// Create Int64
    var Int64: Int64? {
        return self as? Int64
    }
    
    /// Creates UInt64
    var UInt64: UInt64? {
        return self as? UInt64
    }
    
    /// Creates Float
    var Float: Float? {
        return self as? Float
    }
    
    /// Create Bool
    var Bool: Bool? {
        return self as? Bool
    }
    
    /// Create CGFloat
    var CGFloat: CGFloat? {
        return self as? CGFloat
    }
    
    /// Creates NSNumber
    var Number: NSNumber? {
        return self as? NSNumber
    }
    
    /// Creates Date
    var Date: Date? {
        return self as? Date
    }
    
    /// Creates CGPoint
    var CGPoint: CGPoint? {
        return self as? CGPoint
    }
    
    /// Creates CGRect
    var CGRect: CGRect? {
        return self as? CGRect
    }
    
    /// Creates CGAffineTransform
    var CGAffineTransform: CGAffineTransform? {
        return self as? CGAffineTransform
    }
    
    /// Creates a generic array
    var Array: Array<Any>? {
        return self as? Array
    }
    
    /// Creates a array of Dictionaries
    var Dictionary: [String: Any]? {
        return self as? [String: Any]
    }
    
    /// Creates a data with a specified format from a string value
    ///
    /// - Parameter format: Format of the data
    /// - Returns: Returns date if value is a string
    func date(format: String) -> Date? {
        guard let value = self.String else {
            return nil
        }
        
        return value.date(format: format)
    }
}

