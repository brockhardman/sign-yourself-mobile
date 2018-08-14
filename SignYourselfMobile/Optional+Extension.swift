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
    public var String: String? {
        return self as? String
    }
    
    /// Creates URL
    public var URL: URL? {
        return self as? URL
    }
    
    /// Creates Int if one
    public var Int: Int? {
        return self as? Int
    }
    
    /// Creates Double if one
    public var Double: Double? {
        return self as? Double
    }
    
    /// Creates Int8
    public var Int8: Int8? {
        return self as? Int8
    }
    
    /// Creates UInt8
    public var UInt8: UInt8? {
        return self as? UInt8
    }
    
    /// Creates Int16
    public var Int16: Int16? {
        return self as? Int16
    }
    
    /// Creates UInt16
    public var UInt16: UInt16? {
        return self as? UInt16
    }
    
    /// Creates Int32
    public var Int32: Int32? {
        return self as? Int32
    }
    
    /// Create Int64
    public var Int64: Int64? {
        return self as? Int64
    }
    
    /// Creates UInt64
    public var UInt64: UInt64? {
        return self as? UInt64
    }
    
    /// Creates Float
    public var Float: Float? {
        return self as? Float
    }
    
    /// Create Bool
    public var Bool: Bool? {
        return self as? Bool
    }
    
    /// Create CGFloat
    public var CGFloat: CGFloat? {
        return self as? CGFloat
    }
    
    /// Creates NSNumber
    public var Number: NSNumber? {
        return self as? NSNumber
    }
    
    /// Creates Date
    public var Date: Date? {
        return self as? Date
    }
    
    /// Creates CGPoint
    public var CGPoint: CGPoint? {
        return self as? CGPoint
    }
    
    /// Creates CGRect
    public var CGRect: CGRect? {
        return self as? CGRect
    }
    
    /// Creates CGAffineTransform
    public var CGAffineTransform: CGAffineTransform? {
        return self as? CGAffineTransform
    }
    
    /// Creates a generic array
    public var Array: Array<Any>? {
        return self as? Array
    }
    
    /// Creates a array of Dictionaries
    public var Dictionary: [String: Any]? {
        return self as? [String: Any]
    }
    
    /// Creates a data with a specified format from a string value
    ///
    /// - Parameter format: Format of the data
    /// - Returns: Returns date if value is a string
    public func date(format: String) -> Date? {
        guard let value = self.String else {
            return nil
        }
        
        return value.date(format: format)
    }
}

