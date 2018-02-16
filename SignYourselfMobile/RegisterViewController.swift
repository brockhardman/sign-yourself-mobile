//
//  RegisterViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var verifyPasswordTextField: UITextField!
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        SignYourselfAPIClient.shared.register(email: emailTextField.text ?? "", username: usernameTextField.text ?? "", password: passwordTextField.text ?? "", verifyPassword: verifyPasswordTextField.text ?? "", toc: true) { result in
            switch result {
            case .Success(let registerResponse):
                self.processRegisterSuccess(registerResponse: registerResponse as! RegisterResponse)
            case .Errors(let errors):
                self.processRegisterErrors(errors: errors)
            case .Failure(let error):
                self.processRegisterFailure(error: error)
            }
        }
    }
    
    @IBAction func registerWithFacebookButtonTapped(_ sender: UIButton) {
        
    }
    
    func processRegisterSuccess(registerResponse: RegisterResponse) {
        if registerResponse.success! {
            dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: NSNotification.Name(Constants.userDidRegisterNotification), object: nil)
            })
        }
    }
    
    func processRegisterErrors(errors: [String : [String]]) {
        
    }
    
    func processRegisterFailure(error: Error) {
        
    }
}
