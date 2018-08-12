//
//  CollapsingUtil.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation

class CollapsingUtil {
    var previousContentOffset:CGFloat = 0
    var scrollDiff:CGFloat = 0
    var openAmount:CGFloat?
    var percentage:CGFloat?
    var constant:CGFloat = 0
    var absolutePercentage:CGFloat?
    var const:CGFloat = 0
    //MARK:Collapsing Toolbar
    func collapseView(scrollOffsetY: CGFloat,viewHeight:NSLayoutConstraint,minHeight:CGFloat,maxHeight:CGFloat,collapseRange:CGFloat) ->CGFloat {
        scrollDiff = scrollOffsetY - previousContentOffset
        if viewHeight.constant >= minHeight && viewHeight.constant <= maxHeight{
            constant = viewHeight.constant - scrollDiff
            if  constant >= minHeight && constant <= maxHeight{
                viewHeight.constant = constant
                openAmount =  viewHeight.constant - minHeight
                percentage = openAmount! / collapseRange
                absolutePercentage = 1-percentage!
                
            }
        }
        print(scrollDiff)
        previousContentOffset = scrollOffsetY
        return absolutePercentage!
    }
}
