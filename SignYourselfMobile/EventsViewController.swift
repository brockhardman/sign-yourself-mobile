//
//  EventsViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/24/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import UIKit
import ViewPager_Swift

class EventsViewController: UIViewController {
    
    var tabs = [
        ViewPagerTab(title: "ALL", image: #imageLiteral(resourceName: "SettingsIcon")),
        ViewPagerTab(title: "LATEST", image:#imageLiteral(resourceName: "SettingsIcon") ),
        ViewPagerTab(title: "UPCOMMING", image: #imageLiteral(resourceName: "SettingsIcon")),
        ]
    var viewPager:ViewPagerController!
    var options:ViewPagerOptions!
    var tabList = [UIViewController]()
    var collapseDelegate: CollapseDelegate?
    var offset:CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabs()
        setUpViewPager()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    //MARK:Set up ViewPager
    func setUpTabs(){
        let allEventsTabViewController = UIStoryboard(name: "Events", bundle: nil).instantiateViewController(withIdentifier: Constants.ALL_EVENTS_TAB) as? AllEventsTabViewController
//        let latestEventTab = getStoryboard().instantiateViewController(withIdentifier: Constants.LATEST_EVENT_TAB) as? LatestEventTab
//        let upcommingEventTab = getStoryboard().instantiateViewController(withIdentifier: Constants.UPCOMMING_EVENT_TAB) as? UpcommingEventTab
        tabList.append(allEventsTabViewController!)
//        tabList.append(latestEventTab!)
//        tabList.append(upcommingEventTab!)
    }
    func setUpViewPager()  {
        options = getViewPagerOptions(view: self.view)
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        
        self.addChild(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMove(toParent: self)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        options?.viewPagerFrame = self.view.bounds
    }
    
    @objc func didLogin() {
        getEvents()
    }
    
    private func getEvents() {
        if let authorID = UserManager.shared.currentUser?.id! {
            SignYourselfAPIClient.shared.getEvents(authorID:authorID, completionHandlerAPI: { events in
                DispatchQueue.main.async {
                    
                }
            })
        }
    }
}
//MARK:Extension for ViewPager for this Screen
extension EventsViewController: ViewPagerControllerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        return tabList[position]
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension EventsViewController: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}


