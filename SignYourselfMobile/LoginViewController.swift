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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRegister), name: Notification.Name(Constants.userDidRegisterNotification), object: nil)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        SignYourselfAPIClient.shared.login(username: "gashousesmitty@gmail.com", password: "Therealones1") { result in
            switch result {
            case .Success(let loginResponse):
                self.delegate?.processLoginResponse(loginResponse: loginResponse as! LoginResponse)
            case .Errors(let errors):
                debugPrint(errors)
            case .Failure(let error):
                debugPrint(error)
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let registerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        registerController.modalPresentationStyle = .overFullScreen
        present(registerController, animated: true, completion: nil)
    }
    
    @objc func didRegister() {
        
    }
}


