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
        loginController.delegate = self
        present(loginController, animated: true, completion: nil)
    }
}

extension RootViewController : LoginProtocol {
    func processLoginResponse(loginResponse: LoginResponse) {
        SignYourselfAPIManager.shared.accessToken = loginResponse.accessToken ?? ""
        SignYourselfAPIManager.shared.currentUser = loginResponse.user
        SignYourselfAPIManager.shared.loadProfileData(completion: {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name(Constants.userDidLoginNotification), object: nil)
                })
            }
        })
    }
}

