//
//  RootViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/22/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

class RootViewController: TabbedViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showLoginScreen()
    }
    
    func showLoginScreen() {
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
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
