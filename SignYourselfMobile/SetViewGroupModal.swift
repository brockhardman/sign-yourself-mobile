//
//  SetViewGroupModal.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation

class SetViewGroupModal {
    var view:UIView?
    var title:UILabel?
    var subTitle:UILabel?
    
    init(view:UIView,title:UILabel,subTitle:UILabel) {
        self.view = view
        self.title = title
        self.subTitle = subTitle
    }
}
