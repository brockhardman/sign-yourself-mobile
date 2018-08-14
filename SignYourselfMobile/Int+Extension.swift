//
//  Int+Extension.swift
//  Common
//
//  Created by Brock Hardman on 7/1/18.
//  Copyright © 2018 NRG. All rights reserved.
//

extension Int {
    
    private static var commaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    public var commaRepresentation: String {
        return Int.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
