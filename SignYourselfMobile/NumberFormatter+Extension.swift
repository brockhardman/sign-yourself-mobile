//
//  NumberFormatter+Extension.swift
//  Common
//
//  Created by Brock Hardman on 7/11/18.
//  Copyright © 2018 NRG. All rights reserved.
//

extension NumberFormatter {
    
    public static var decimalNumberFormater: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
