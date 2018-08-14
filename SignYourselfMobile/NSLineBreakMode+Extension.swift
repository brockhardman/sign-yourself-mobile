//
//  NSLineBreakMode+Extension.swift
//  Reliant
//
//  Created by Woodall, Kristopher on 10/18/16.
//  Copyright © 2016 Relaint. All rights reserved.
//

import Foundation

/** 
    
 Key value used from plist to set the text alingnment of the title of the cell 
 
 - wordWrap: Wrap at word boundrais. Default
 - charWrap: Wrap at character boundaries.
 - clipping: Clip at end of boundray
 - truncatingHead: Truncate at head of line.
 - truncatingTail: Truncate at tail of line.
 - truncatingMiddle: Truncate middle of line.
 
 */
enum LineBreakModeName: String {
    case wordWrap = "byWordWrapping"
    case charWrap = "byCharWrapping"
    case clipping = "byClipping"
    case truncatingHead = "byTruncatingHead"
    case truncatingTail = "byTruncatingTail"
    case truncatingMiddle = "byTruncatingMiddle"
    
    init(name: String) {
        self.init(rawValue: name)!
    }
}

extension NSLineBreakMode {
    
    /** 
     
     Converts text alignment name from plist into NSLineBreakMode
     
     - paramter forName: Name of the type of Line break mode. 
     
    */
    static func mode(forName: String) -> NSLineBreakMode {
        let mode = LineBreakModeName(name: forName)
        switch mode {
        case .wordWrap: return NSLineBreakMode.byWordWrapping
        case .charWrap: return NSLineBreakMode.byCharWrapping
        case .clipping: return NSLineBreakMode.byClipping
        case .truncatingHead: return NSLineBreakMode.byTruncatingHead
        case .truncatingTail: return NSLineBreakMode.byTruncatingTail
        case .truncatingMiddle: return NSLineBreakMode.byTruncatingMiddle
        }
    }
}
