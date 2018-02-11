//
//  LoginViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

protocol LoginProtocol : class {
    func processLoginResponse(loginResponse: LoginResponse)
}

class LoginViewController: UIViewController {
    
    weak var delegate : LoginProtocol?
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        SignYourselfAPIClient.shared.login(username: "brock.hardman@sbcglobal.net", password: "Ngunayic14!") { result in
            switch result {
            case .Success(let loginResponse):
                self.delegate?.processLoginResponse(loginResponse: loginResponse as! LoginResponse)
            case .Failure(let error):
                debugPrint(error)
            }
        }
    }
}

