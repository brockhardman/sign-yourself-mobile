//
//  CGPoint+Extension.swift
//  Common
//
//  Created by Brock Hardman on 3/26/18.
//  Copyright © 2018 NRG. All rights reserved.
//

import Foundation

extension CGPoint {
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}


