//
//  HomeViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation

class HomeViewController: ActiveViewController, UIGestureRecognizerDelegate {
    //MARK:Properties
    @IBOutlet weak var easyView: UIView!
    @IBOutlet weak var mediumView: UIView!
    @IBOutlet weak var hardView: UIView!
    @IBOutlet weak var easy1View: UIView!
    @IBOutlet weak var marketingView: UIView!
    @IBOutlet weak var myPageView: UIView!
    @IBOutlet weak var myProfileView: UIView!
    @IBOutlet weak var btnAddNew: UIButton!
    
    @IBOutlet weak var easyTitle: UILabel!
    @IBOutlet weak var mediumTitle: UILabel!
    @IBOutlet weak var hardTitle: UILabel!
    @IBOutlet weak var easy1Title: UILabel!
    
    @IBOutlet weak var easyLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var hardLabel: UILabel!
    @IBOutlet weak var easy1Label: UILabel!
    
//    var addNewProjectScreen:AddNewProjectScreen?
//    var projectDetailScreen:ProjectDetailScreen?
//    var profileScreen:ProfileScreen?
//    var marketingScreen:MarketingScreen?
//    
//    var viewGroupList = [SetViewGroupModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeScreens()
        setUpGestures()
        setUpViewList()
    }
    func setUpViewList() {
//        viewGroupList.append(SetViewGroupModal.init(view: easyView, title: easyTitle, subTitle: easyLabel))
//        viewGroupList.append(SetViewGroupModal.init(view: mediumView, title: mediumTitle, subTitle: mediumLabel))
//        viewGroupList.append(SetViewGroupModal.init(view: hardView, title: hardTitle, subTitle: hardLabel))
//        viewGroupList.append(SetViewGroupModal.init(view: easy1View, title: easy1Title, subTitle: easy1Label))
    }
    
    //MARK:View actions
    @IBAction func btnAddNewAction(_ sender: UIButton) {
        //present(addNewProjectScreen!, animated: true, completion: nil)
    }
    @objc func easyTapped() {
        //setUpViewGroup(viewTapped: easyView, setViewGroupModalList: viewGroupList)
    }
    @objc func mediumTapped() {
        //setUpViewGroup(viewTapped: mediumView, setViewGroupModalList: viewGroupList)
    }
    @objc func hardTapped() {
        //setUpViewGroup(viewTapped: hardView, setViewGroupModalList: viewGroupList)
    }
    @objc func easy1Tapped() {
        //setUpViewGroup(viewTapped: easy1View, setViewGroupModalList: viewGroupList)
    }
    @objc func marketingTapped() {
        //present(marketingScreen!, animated: true, completion: nil)
    }
    @objc func myPageTapped() {
        
    }
    @objc func myProfileTapped() {
        //present(profileScreen!, animated: true, completion: nil)
    }
    
    
    //MARK:Set up the Gestures
    func setUpGestures()  {
        let easyGesture = UITapGestureRecognizer.init(target: self, action: #selector(easyTapped))
        easyGesture.delegate = self
        easyView.isUserInteractionEnabled = true
        easyView.addGestureRecognizer(easyGesture)
        
        let mediumGesture = UITapGestureRecognizer.init(target: self, action: #selector(mediumTapped))
        mediumGesture.delegate = self
        mediumView.isUserInteractionEnabled = true
        mediumView.addGestureRecognizer(mediumGesture)
        
        let hardGesture = UITapGestureRecognizer.init(target: self, action: #selector(hardTapped))
        hardGesture.delegate = self
        hardView.isUserInteractionEnabled = true
        hardView.addGestureRecognizer(hardGesture)
        
        let easy1Gesture = UITapGestureRecognizer.init(target: self, action: #selector(easy1Tapped))
        easy1Gesture.delegate = self
        easy1View.isUserInteractionEnabled = true
        easy1View.addGestureRecognizer(easy1Gesture)
        
        let marketingGesture = UITapGestureRecognizer.init(target: self, action: #selector(marketingTapped))
        marketingGesture.delegate = self
        marketingView.isUserInteractionEnabled = true
        marketingView.addGestureRecognizer(marketingGesture)
        
        let myPageGesture = UITapGestureRecognizer.init(target: self, action: #selector(myPageTapped))
        myPageGesture.delegate = self
        myPageView.isUserInteractionEnabled = true
        myPageView.addGestureRecognizer(myPageGesture)
        
        let myProfileGesture = UITapGestureRecognizer.init(target: self, action: #selector(myProfileTapped))
        myProfileGesture.delegate = self
        myProfileView.isUserInteractionEnabled = true
        myProfileView.addGestureRecognizer(myProfileGesture)
    }
    
    private func initializeScreens()  {
//        addNewProjectScreen = getStoryboard().instantiateViewController(withIdentifier: Constants.ADD_NEWPROJECT_SCREEN) as? AddNewProjectScreen
//        projectDetailScreen = getStoryboard().instantiateViewController(withIdentifier: Constants.PROJECT_DETAIL_SCREEN) as? ProjectDetailScreen
//        profileScreen = getStoryboard().instantiateViewController(withIdentifier: Constants.PROFILE_SCREEN) as? ProfileScreen
//        marketingScreen = getStoryboard().instantiateViewController(withIdentifier: Constants.MARKETING_SCREEN) as? MarketingScreen
//
//        projectDetailScreen?.modalTransitionStyle = .crossDissolve
//        addNewProjectScreen?.modalTransitionStyle = .crossDissolve
//        profileScreen?.modalTransitionStyle = .crossDissolve
//        marketingScreen?.modalTransitionStyle = .crossDissolve
    }
    
}
//MARK:Extension for Collection View for this Screen
extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectsCollectionCell", for: indexPath) as! ProjectsCollectionCell
        return cell
    }}
extension HomeViewController : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //present(projectDetailScreen!, animated: true, completion: nil)
    }
}
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
}
