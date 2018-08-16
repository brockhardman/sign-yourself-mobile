//
//  RootViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/22/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

import CoreLocation

class RootViewController: TabbedViewController {
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLoginScreen), name: NSNotification.Name(Constants.signInNeededNotification), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserManager.shared.userIsLoggedIn() {
            showLoginScreen()
        }
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    @objc func showLoginScreen() {
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.LOGIN_SCREEN) as! LoginViewController
        loginController.modalPresentationStyle = .overFullScreen
        loginController.modalTransitionStyle = .crossDissolve
        loginController.delegate = self
        present(loginController, animated: true, completion: nil)
    }
}

extension RootViewController : LoginProtocol {
    func processLoginResponse(loginResponse: LoginResponse) {
        UserManager.shared.accessToken = loginResponse.accessToken ?? ""
        UserManager.shared.currentUser = loginResponse.user
        
        if let userId = UserManager.shared.currentUser?.id {
            
            SignYourselfAPIClient.shared.getProfileData(profileID: userId) { result in
                
                switch result {
                case .Success(let profile):
                    UserManager.shared.profileData = profile as? Profile
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: {
                            NotificationCenter.default.post(name: NSNotification.Name(Constants.userDidLoginNotification), object: nil)
                        })
                    }
                case .Errors(let errors):
                    debugPrint(errors)
                case .Failure(let error):
                    debugPrint(error)
                }
            }
            
            SignYourselfAPIClient.shared.getEvents(authorID: userId) { result in
                
                switch result {
                case .Success(let events):
                    debugPrint(events)
                case .Errors(let errors):
                    debugPrint(errors)
                case .Failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
}

