//
//  EventsViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/24/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

class EventsViewController: ActiveViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    @objc func didLogin() {
        getEvents()
    }
    
    private func getEvents() {
        if let authorID = SignYourselfAPIManager.shared.currentUser?.id! {
            SignYourselfAPIClient.shared.getEvents(authorID:authorID, completionHandlerAPI: { events in
                DispatchQueue.main.async {
                    
                }
            })
        }
    }
}
