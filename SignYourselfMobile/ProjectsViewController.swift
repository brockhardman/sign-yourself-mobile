//
//  ProjectsViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/16/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class ProjectsViewController: ActiveViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    @objc func didLogin() {
        getProjects()
    }
    
    private func getProjects() {
        if let ownerID = SignYourselfAPIManager.shared.currentUser?.id! {
            SignYourselfAPIClient.shared.getProjects(ownerID:ownerID, completionHandlerAPI: { projects in
                DispatchQueue.main.async {
                    
                }
            })
        }
    }
}

