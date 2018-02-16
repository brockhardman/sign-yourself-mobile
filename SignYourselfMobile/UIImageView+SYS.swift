//
//  UIImageView+SYS.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

extension UIImageView {
    
    func setRounded(borderWidth: CGFloat, borderColor: UIColor) {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
}
