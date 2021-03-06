//
//  ProjectDetailViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController,UIGestureRecognizerDelegate,CollapseDelegate{
    
    
    //MARK:Properties
    @IBOutlet weak var backArrowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerFrontView: UIView!
    @IBOutlet weak var labelLeading: NSLayoutConstraint!
    
    
    var tabs = [
        ViewPagerTab(title: "Info", image: #imageLiteral(resourceName: "SettingsIcon")),
        ViewPagerTab(title: "Media", image:#imageLiteral(resourceName: "SettingsIcon") ),
        ViewPagerTab(title: "Updates", image: #imageLiteral(resourceName: "SettingsIcon")),
        ViewPagerTab(title: "Join Project", image: #imageLiteral(resourceName: "SettingsIcon")),
        ViewPagerTab(title: "Comments", image:#imageLiteral(resourceName: "SettingsIcon") ),
        ]
    var viewPager:ViewPagerController!
    var options:ViewPagerOptions!
    var tabList = [UIViewController]()
    
    var previousContentOffset:CGFloat = 0
    var scrollDiff:CGFloat = 0
    var range:CGFloat = 155
    var openAmount:CGFloat?
    var percentage:CGFloat?
    var constant:CGFloat = 0
    var absolutePercentage:CGFloat?
    var const:CGFloat = 0
    var collapsingUtil = CollapsingUtil()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
        setUpTabs()
        setUpViewPager()
        addDonateButton()
        print(headerViewHeight.constant)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpViews()
    }
    
    private func addDonateButton() {
        let donateButton = UIButton(type: .roundedRect)
        donateButton.setTitle("Donate Now", for: .normal)
        donateButton.addTarget(self, action: #selector(donateButtonTapped), for: .touchUpInside)
        headerView.addSubview(donateButton)
        headerView.bringSubviewToFront(donateButton)
        donateButton.frame = CGRect(x: 200, y: 50, width: 100, height: 40)
        donateButton.backgroundColor = .red
    }
    
    //MARK:Views Actions
    @objc func backArrowViewTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func donateButtonTapped() {
        let donateController = UIStoryboard(name: "Contributions", bundle: nil).instantiateViewController(withIdentifier: "DonateViewController")
        present(donateController, animated: true, completion: nil)
    }
    
    //MARK:Set Up Views from View will appear
    private func setUpViews() {
        headerViewHeight.constant = 200
    }
    //MARK:Collapsing Toolbar
    func collapse(offset: CGFloat) {
        absolutePercentage  = collapsingUtil.collapseView(scrollOffsetY: offset, viewHeight: headerViewHeight, minHeight: 45, maxHeight: 200,collapseRange:155)
        
        headerFrontView.alpha = absolutePercentage!
        const = 15 + 30*absolutePercentage!
        labelLeading.constant = +const
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
//        let infoTab = getStoryboard().instantiateViewController(withIdentifier: Constants.UPCOMMING_EVENT_TAB) as? UpcommingEventTab
        let mediaTabViewController = UIStoryboard(name: "Media", bundle: nil).instantiateViewController(withIdentifier: Constants.MEDIA_TAB_VIEW_CONTROLLER) as! MediaTabViewController
        mediaTabViewController.collapseDelegate = self
//        let updatesTab = getStoryboard().instantiateViewController(withIdentifier: Constants.UPCOMMING_EVENT_TAB) as? UpcommingEventTab
//        let joinProjectTab = getStoryboard().instantiateViewController(withIdentifier: Constants.UPCOMMING_EVENT_TAB) as? UpcommingEventTab
//        let commentsTab = getStoryboard().instantiateViewController(withIdentifier: Constants.UPCOMMING_EVENT_TAB) as? UpcommingEventTab
//
//        tabList.append(infoTab!)
        tabList.append(mediaTabViewController)
//        tabList.append(updatesTab!)
//        tabList.append(joinProjectTab!)
//        tabList.append(commentsTab!)
    }
    func setUpViewPager()  {
        options = getViewPagerOptions(view: self.view)
        viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        
        self.addChild(viewPager)
        self.containerView.addSubview(viewPager.view)
        viewPager.didMove(toParent: self)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        options?.viewPagerFrame = self.view.bounds
    }
}
//MARK:Extension for ViewPager for this Screen
extension ProjectDetailViewController: ViewPagerControllerDataSource {
    
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

extension ProjectDetailViewController: ViewPagerControllerDelegate {
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}



