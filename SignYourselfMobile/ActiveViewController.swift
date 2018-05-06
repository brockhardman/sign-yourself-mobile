//
//  ActiveViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 5/2/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

class ActiveViewController: UIViewController {
    
    public var navigationTitle = String()
    public var navigationImage = String()
    
    public func configure(title:String, image:String) {
        self.navigationTitle = title;
        self.navigationImage = image;
    }
}
