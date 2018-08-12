//
//  RegisterViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UIGestureRecognizerDelegate {
    //MARK:Properties
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var stageNameField: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var iAgreeView: UIView!
    @IBOutlet weak var btnIAgree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
        btnSignUp.roundCorners(cornerRadius: btnSignUp.frame.size.height/2)
    }
    //MARK:Setting up the Gestures on Views
    func setUpGestures() {
        let mSignIn = UITapGestureRecognizer(target: self, action: #selector(self.signInTapped))
        mSignIn.delegate = self
        self.signInLabel.isUserInteractionEnabled = true
        self.signInLabel!.addGestureRecognizer(mSignIn)
        
        let iAgreeViewGesture = UITapGestureRecognizer(target: self, action: #selector(self.iAgreeViewGestureTapped))
        iAgreeViewGesture.delegate = self
        self.iAgreeView.isUserInteractionEnabled = true
        self.iAgreeView!.addGestureRecognizer(iAgreeViewGesture)
    }
    //MARK:Views Actions
    @objc func signInTapped(){
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(Constants.signInNeededNotification), object: nil)
        }
    }
    
    @objc func iAgreeViewGestureTapped()  {
        //setUpButton(button: btnIAgree,checkedImage: #imageLiteral(resourceName: "check"),uncheckedImage: #imageLiteral(resourceName: "RoundIcon"))
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
//        SignYourselfAPIClient.shared.register(email: emailField.text ?? "", username: usernameTextField.text ?? "", password: passwordField.text ?? "", verifyPassword: verifyPasswordTextField.text ?? "", toc: true) { result in
//            switch result {
//            case .Success(let registerResponse):
//                self.processRegisterSuccess(registerResponse: registerResponse as! RegisterResponse)
//            case .Errors(let errors):
//                self.processRegisterErrors(errors: errors)
//            case .Failure(let error):
//                self.processRegisterFailure(error: error)
//            }
//        }
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
