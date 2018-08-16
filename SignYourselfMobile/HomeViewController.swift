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
    @IBOutlet weak var marketingView: UIView!
    @IBOutlet weak var myPageView: UIView!
    @IBOutlet weak var myProfileView: UIView!
    @IBOutlet weak var btnAddNew: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    var projects: [Project] = []
    
//    var addNewProjectScreen:AddNewProjectScreen?
    var projectDetailViewController:ProjectDetailViewController?
    var profileViewController:ProfileViewController?
//    var marketingScreen:MarketingScreen?
//    
//    var viewGroupList = [SetViewGroupModal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeScreens()
        setUpGestures()
        setUpViewList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    @objc func didLogin() {
        getProjects()
    }
    
    func getProjects() {
        if let ownerID = UserManager.shared.currentUser?.id! {
            SignYourselfAPIClient.shared.getProjects(ownerID:ownerID, completionHandlerAPI: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .Success(let projectsResponse):
                        if let projects = projectsResponse as? [Project] {
                            self.projects = projects
                            self.collectionView.reloadData()
                        }
                    case .Errors(let errors):
                        debugPrint(errors)
                    case .Failure(let error):
                        debugPrint(error)
                    }
                }
            })
        }
    }
    
    @objc func userDidLoad() {
        collectionView.reloadData()
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
        present(profileViewController!, animated: true, completion: nil)
    }
    
    
    //MARK:Set up the Gestures
    func setUpGestures()  {
        
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
        projectDetailViewController = UIStoryboard(name: "Projects", bundle: nil).instantiateViewController(withIdentifier: Constants.PROJECT_DETAIL_SCREEN) as? ProjectDetailViewController
        profileViewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: Constants.PROFILE_SCREEN) as? ProfileViewController
//        marketingScreen = getStoryboard().instantiateViewController(withIdentifier: Constants.MARKETING_SCREEN) as? MarketingScreen
//
        projectDetailViewController?.modalTransitionStyle = .crossDissolve
//        addNewProjectScreen?.modalTransitionStyle = .crossDissolve
        profileViewController?.modalTransitionStyle = .crossDissolve
//        marketingScreen?.modalTransitionStyle = .crossDissolve
    }
    
}
//MARK:Extension for Collection View for this Screen
extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
        cell.configureWithProject(project: projects[indexPath.item])
        
        return cell
    }}
extension HomeViewController : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(projectDetailViewController!, animated: true, completion: nil)
    }
}
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
}
