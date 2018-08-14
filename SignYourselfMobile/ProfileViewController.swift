//
//  ProfileViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/22/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import SwiftyJSON
import ViewPager_Swift

class ProfileViewController: ActiveViewController, UIGestureRecognizerDelegate, CollapseDelegate {
    
    
    //MARK:Properties
    @IBOutlet weak var backArrowView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerFrontView: UIView!
    @IBOutlet weak var btnReadMore: UIButton!
    
    var collapseUtil = CollapsingUtil()
    var absolutePercenatge:CGFloat = 0
    var tabs = [
        ViewPagerTab(title: "MEDIA", image: #imageLiteral(resourceName: "SettingsIcon")),
        ViewPagerTab(title: "PROJECTS", image:#imageLiteral(resourceName: "SettingsIcon") ),
        ViewPagerTab(title: "EVENTS", image: #imageLiteral(resourceName: "SettingsIcon")),
        ]
    var viewPager:ViewPagerController!
    var options:ViewPagerOptions!
    var tabList = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
        setUpTabs()
        setUpViewPager()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    @objc func didLogin() {
        
    }
    
    //MARK:Views Actions
    @objc func backArrowViewTapped(){
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnReadMoreAction(_ sender: UIButton) {
    }
    
    func collapse(offset: CGFloat) {
        absolutePercenatge = collapseUtil.collapseView(scrollOffsetY: offset, viewHeight: headerViewHeight, minHeight: 65, maxHeight: 280,collapseRange:215)
        
        headerFrontView.alpha = absolutePercenatge
        if absolutePercenatge < 0.8{
            btnReadMore.isHidden = true
            
        }else{
            btnReadMore.isHidden = false
        }
    }
    //MARK:Setting up the Gestures on Views
    func setUpGestures() {
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(self.backArrowViewTapped))
        backGesture.delegate = self
        self.backArrowView.isUserInteractionEnabled = true
        self.backArrowView!.addGestureRecognizer(backGesture)
    }
    
    //MARK:Set up ViewPager
    func setUpTabs(){
        let mediaTabViewController = UIStoryboard(name: "Media", bundle: nil).instantiateViewController(withIdentifier: Constants.MEDIA_TAB_VIEW_CONTROLLER) as! MediaTabViewController
        mediaTabViewController.collapseDelegate = self
        let projectsTabViewController = UIStoryboard(name: "Projects", bundle: nil).instantiateViewController(withIdentifier: Constants.PROJECTS_SCREEN) as! ProjectsViewController
        projectsTabViewController.collapseDelegate = self
        let eventsTabViewController = UIStoryboard(name: "Events", bundle: nil).instantiateViewController(withIdentifier: Constants.EVENTS_SCREEN) as! EventsViewController
        eventsTabViewController.collapseDelegate = self
        tabList.append(mediaTabViewController)
        tabList.append(projectsTabViewController)
        tabList.append(eventsTabViewController)
    }
    func setUpViewPager()  {
        options = getViewPagerOptions(view: self.view)
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        
        self.addChildViewController(viewPager)
        self.containerView.addSubview(viewPager.view)
        viewPager.didMove(toParentViewController: self)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        options?.viewPagerFrame = self.view.bounds
    }
}

//MARK:Extension for ViewPager for this Screen
extension ProfileViewController: ViewPagerControllerDataSource {
    
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

extension ProfileViewController: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}


