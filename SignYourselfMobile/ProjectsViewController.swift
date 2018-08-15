//
//  ProjectsViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/16/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class ProjectsViewController: ActiveViewController {
    
    var projectDetailScreen: ProjectDetailViewController?
    var collapseDelegate: CollapseDelegate?
    var offset:CGFloat?
    var projects: [Project] = []
    
    @IBOutlet weak var projectsCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeScreens()
        searchView.dropShadow()
        
         NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: Notification.Name(Constants.userDidLoginNotification), object: nil)
    }
    
    private func initializeScreens()      {
        projectDetailScreen = UIStoryboard(name: "Projects", bundle: nil).instantiateViewController(withIdentifier: Constants.PROJECT_DETAIL_SCREEN) as? ProjectDetailViewController
        projectDetailScreen?.modalTransitionStyle = .crossDissolve
    }
    
    @objc func didLogin() {
        getProjects()
    }
    
    private func getProjects() {
        if let ownerID = SignYourselfAPIManager.shared.currentUser?.id! {
            SignYourselfAPIClient.shared.getProjects(ownerID:ownerID, completionHandlerAPI: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .Success(let projectsResponse):
                        if let projects = projectsResponse as? [Project] {
                            self.projects = projects
                            self.projectsCollectionView.reloadData()
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
}

//MARK:Extension for Collection View for this Screen
extension ProjectsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as? ProjectCell
        cell?.configureWithProject(project: self.projects[indexPath.item])
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offset = scrollView.contentOffset.y
        collapseDelegate?.collapse(offset: offset!)
    }
}
extension ProjectsViewController : UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        present(projectDetailScreen!, animated: true, completion: nil)
    }
    
}
extension ProjectsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.width/2-5, height: 210)
    }
}


