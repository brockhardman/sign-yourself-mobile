//
//  NSTextAlignment+Extension.swift
//  Reliant
//
//  Created by Woodall, Kristopher on 10/17/16.
//  Copyright © 2016 Relaint. All rights reserved.
//

import UIKit

/**
 
 Key value used from plist to set the text alingnment of the title of the cell
 
 - left: Visually left aligned
 - center: Visually centered
 - right: Visually right aligned.
 
 */

enum TextAlignmentName: String {
    case left = "left"
    case center = "center"
    case right = "right"
    
    init(name: String) {
        self.init(rawValue: name)!
    }
}

extension NSTextAlignment {

    /** 
 
     Converts text alignment name from plist into NSTextAlignment
     
     - parameter fromName: Name of the type of text alignment. 
     */
    static func alignment(fromName: String) -> NSTextAlignment {
        let alignment = TextAlignmentName(name: fromName)
        switch alignment {
        case .left: return NSTextAlignment.left
        case .right: return NSTextAlignment.right
        case .center: return NSTextAlignment.center
        }
    }
}
