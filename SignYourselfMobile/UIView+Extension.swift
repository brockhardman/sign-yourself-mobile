//
//  UIView+Extension.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

extension UIView {
    func roundCorners(cornerRadius:CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}

