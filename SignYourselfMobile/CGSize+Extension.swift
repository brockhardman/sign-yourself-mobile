//
//  CGSize+Extension.swift
//  Utility
//
//  Created by Woodall, Kristopher on 3/15/17.
//  Copyright © 2017 Reliant. All rights reserved.
//

import Foundation

extension CGSize {
    
    /// Calculates the aspect ratio of the size.
    ///
    /// - returns: aspectRatio The aspect ratio of the size.
    public var aspectRatio: CGFloat {
        if height == 0 { return 1 }
        return width / height
    }
    
    /// Finds a new size constrained by a size keeping the aspect ratio.
    ///
    /// - parameter size: The contraining size.
    /// - returns: size A new size that fits inside the contraining size with the same aspect ratio.
    public func aspectFit(size: CGSize) -> CGSize {
        let aspectWidth = round(aspectRatio * size.height)
        let aspectHeight = round(size.width / aspectRatio)
        
        if aspectWidth > size.width {
            return CGSize(width: size.width, height: aspectHeight)
        } else {
            return CGSize(width: aspectWidth, height: size.height)
        }
    }
    
    /// Finds a new size filling the given size while keeping the aspect ratio.
    ///
    /// - parameter size: The contraining size.
    /// - returns: size A new size that fills the contraining size keeping the same aspect ratio.
    public func aspectFill(size: CGSize) -> CGSize {
        let aspectWidth = round(aspectRatio * size.height)
        let aspectHeight = round(size.width / aspectRatio)
        
        if aspectWidth > size.width {
            return CGSize(width: aspectWidth, height: size.height)
        } else {
            return CGSize(width: size.width, height: aspectHeight)
        }
    }
}