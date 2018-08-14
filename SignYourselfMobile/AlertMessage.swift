//
//  AlertMessage.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/13/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

public class AlertMessage {
    
    // MARK: -  Variables
    
    /// Title of the alert.
    var title: String?
    
    /// Message of the alert.
    var message: String?
    
    /// Title of the Ok button. Defaults to 'OK'
    var okTitle: String = "OK"
    
    /// Title of the cancle button. Defaults to 'Cancel'
    var cancelTitle: String = "Cancel"
    
    // MARK: - Private Variables
    
    /// Handler for when the user taps the ok button.
    var okHandler: ((UIAlertAction) -> Void)?
    
    /// Handler for when the user taps the cancel button.
    var cancelHandler: ((UIAlertAction) -> Void)?
    
    // MARK: - Initializer
    
    init() { }
    
    // MARK: -  Method
    
    /**
     Sets the handler for when the user taps the 'Ok' button
     
     - Parameter handler: Closure to call when the user taps ok.
     */
    public func setOkHandler(_ handler: ((UIAlertAction) -> Void)?) {
        okHandler = handler
    }
    
    /**
     Set the handler for when the user taps the 'Cancel' button.
     
     - Parameter handler: Closure to call when the user taps the cancel button.
     */
    
    public func setCancelHandler(_ handler: ((UIAlertAction) -> Void)?) {
        cancelHandler = handler
    }
    
    /// Presents the alert view.
    public func show() {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelHandler != nil {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelHandler)
            alertController.addAction(cancelAction)
            cancelHandler = nil
        }
        
        if okHandler != nil {
            let okAction = UIAlertAction(title: okTitle, style: .default, handler: okHandler)
            alertController.addAction(okAction)
            okHandler = nil
        }
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while (topController.presentedViewController != nil) {
                topController = topController.presentedViewController!
            }
            
            topController.present(alertController, animated: true, completion: nil)
        }
    }
}

