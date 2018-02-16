//
//  ProfileViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/22/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import SwiftyJSON

class ProfileViewController: ActiveViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.backgroundColor = UIColor.greenBackgroundColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    @objc func didLogin() {
        
    }
}
