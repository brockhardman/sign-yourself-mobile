//
//  DonateViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 2/5/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import PassKit
import Intents

class DonateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        addApplePayButton()
    }
    
    private func addApplePayButton() {
        let applePayButton = PKPaymentButton(paymentButtonType: .donate, paymentButtonStyle: .black)
        view.addSubview(applePayButton)
        applePayButton.center = view.center
    }
    
    
}

//class IntentHandler: INExtension, INRequestPaymentIntentHandling {
//
//    let paymentHandler = PaymentHandler()
//
//    func handle(intent: INRequestPaymentIntent, completion: @escaping (INRequestPaymentIntentResponse) -> Void) {
//
//        var response = INRequestRideIntentResponse(code: .success, userActivity: nil)
//        let rideStatus = INRideStatus()
//
//        // Apple Pay Payment
//
//        paymentHandler.startPayment() { (success) in
//
//            if success {
//
//                var driverName = PersonNameComponents()
//
//                driverName.givenName = "Johnny"
//
//                driverName.familyName = "A"
//
//                let driverHandle = INPersonHandle(value: "john-appleseed@mac.com", type: .emailAddress)
//
//
//
//                rideStatus.driver = INRideDriver(personHandle: driverHandle, nameComponents: driverName, displayName: nil, image: nil, contactIdentifier: nil, customIdentifier: nil)
//
//            } else {
//
//                response = INRequestRideIntentResponse(code: .failure, userActivity: nil)
//
//            }
//
//            completion(response)
//
//        }
//    }
//
//
//    func resolveUsesApplePayForPayment(forRequestRide intent: INRequestRideIntent, with completion: (INBooleanResolutionResult) -> Void) {
//
//        completion(INBooleanResolutionResult.success(with: true))
//
//    }
//}
