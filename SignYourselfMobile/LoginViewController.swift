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

class LoginViewController: UIViewController, UIGestureRecognizerDelegate    {
    
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnLogInWithFacebook: UIButton!
    @IBOutlet weak var rememberView: UIView!
    @IBOutlet weak var btnRemember: UIButton!
    
    weak var delegate : LoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGestures()
        btnSignIn.roundCorners(cornerRadius: btnSignIn.frame.size.height/2)
        btnLogInWithFacebook.roundCorners(cornerRadius: btnLogInWithFacebook.frame.size.height/2)
    }
    //MARK:Setting up the Gestures on Views
    func setUpGestures() {
        let sigupGesture = UITapGestureRecognizer(target: self, action: #selector(self.signUpTapped))
        sigupGesture.delegate = self
        self.signUpLabel.isUserInteractionEnabled = true
        self.signUpLabel!.addGestureRecognizer(sigupGesture)
        
        let rememberViewGesture = UITapGestureRecognizer(target: self, action: #selector(rememberViewTapped))
        rememberViewGesture.delegate = self
        self.rememberView.isUserInteractionEnabled = true
        self.rememberView!.addGestureRecognizer(rememberViewGesture)
    }
    //MARK:View Actions
    @objc func signUpTapped(){
        let signUpController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.REGISTER_SCREEN) as! RegisterViewController
        signUpController.modalPresentationStyle = .overFullScreen
        signUpController.modalTransitionStyle = .crossDissolve
        present(signUpController, animated: true, completion: nil)
    }
    @objc func rememberViewTapped() {
        setUpButton(button: btnRemember,checkedImage: #imageLiteral(resourceName: "check"),uncheckedImage: #imageLiteral(resourceName: "RoundIcon"))
    }
    @IBAction func btnSignInAction(_ sender: UIButton) {
        SignYourselfAPIClient.shared.login(username: "gashousesmitty@gmail.com", password: "Therealones1") { result in
            switch result {
            case .Success(let loginResponse):
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.loggedInKey)
                self.delegate?.processLoginResponse(loginResponse: loginResponse as! LoginResponse)
            case .Errors(let errors):
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.loggedInKey)
                debugPrint(errors)
            case .Failure(let error):
                UserDefaults.standard.set(false, forKey: UserDefaultKeys.loggedInKey)
                debugPrint(error)
            }
        }
        
    }
    
    @IBAction func btnRememberTapped(_ sender: UIButton) {
        setUpButton(button: sender,checkedImage: #imageLiteral(resourceName: "check"),uncheckedImage: #imageLiteral(resourceName: "RoundIcon"))
    }
    
    @IBAction func btnFacebookAction(_ sender: UIButton) {
        
    }
}


