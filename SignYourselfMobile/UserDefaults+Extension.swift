//
//  UserDefaults+Extension.swift
//  Reliant
//
//  Created by Woodall, Kristopher on 9/12/16.
//  Copyright © 2016 Woodall, Kristopher. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    struct DefaultKeys {
        static let loggedInKey = "loggedIn"
        static let userJustLoggedIn = "userJustLoggedIn"
        static let contentCheckKey = "contentCheckKey"
        static let contentUpdateDateKey = "contentUpdateDateKey"
        static let contentVersionNumberKey = "versionNumberKey"
        static let touchIDKey = "touchIDKey"
        static let touchIdEnabledMessageKey = "touchIDEnabledMessageKey"
        static let introDemoKey = "introDemoKey"
        static let rememberCredentialKey = "rememberCredentialKey"
        static let firstTimeLoadKey = "firstTimeLoadKey"
        static let touchIDPopupKey = "touchIDPopuKey"
        static let tabBarIndexKey = "tabBarIndex"
    }
    
    /**
     Checks to see if the user has logged in.
     */
    public class func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.loggedInKey)
    }
    
    /**
     Sets if the user has logged in or not.
     
     - parameter loggedIn: True if the user has logged in.
     */
    public class func setUserLoggedIn(_ loggedIn: Bool)  {
        UserDefaults.standard.set(loggedIn, forKey: DefaultKeys.loggedInKey)
    }
    
    /**
     Last date the application content was updated.
     */
    public class func lastContentUpdateDate() -> Date? {
        return UserDefaults.standard.object(forKey: DefaultKeys.contentUpdateDateKey) as? Date
    }
    
    /**
     Sets the last date the application content was updated.
     
     - parameter date: Date content was updated.
     */
    
    public class func setContentUpdateDate(_ date: Date) {
        UserDefaults.standard.set(date, forKey: DefaultKeys.contentUpdateDateKey)
    }
    
    /**
     Returns the Content version number from API.
     */
    
    public class func contentVersionNumber() -> Int? {
        
        guard let number = UserDefaults.standard.object(forKey: DefaultKeys.contentVersionNumberKey) as? NSNumber else {
            return nil
        }
        
        return number.intValue
    }
    
    /**
     Sets the current content version number from API.
     */
    
    public class func setContentVersionNumber(_ number: Int) {
        UserDefaults.standard.set(NSNumber(value: number as Int), forKey: DefaultKeys.contentVersionNumberKey)
    }
    
    /**
     
     Sets if touch id has been enabled
     
     - parameter enable: Enables or disable touch id
     */
    
    public class func enableTouchID(_ enable: Bool) {
        UserDefaults.standard.set(enable, forKey: DefaultKeys.touchIDKey)
    }
    
    /**
     Indicates if touch ID has been enabled.
     */
    public class func isTouchIDEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.touchIDKey)
    }
    
    /**
     Indicates if the touch ID popup has been displayed.
     */
    public class func didDisplayTouchIDPopUp() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.touchIDPopupKey)
    }
    
    /**
     Set if the touch ID popup has been displayed.
     
     - parameter displayed: True if displyed false if not.
     */
    public class func setDisplayedTouchIDPopUp(_ displayed: Bool) {
        UserDefaults.standard.set(displayed, forKey: DefaultKeys.touchIDPopupKey)
    }
    
    /**
     Indicates if the touch ID enabled message has been displayed.
     */
    public class func didDisplayTouchIDEnabledNotification() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.touchIdEnabledMessageKey)
    }
    
    /**
     Set if the touch ID enabled message has been displayed.
     
     - parameter displayed: True if displyed false if not.
     */
    public class func setDisplayedTouchIDEnabledMessage(_ displayed: Bool) {
        UserDefaults.standard.set(displayed, forKey: DefaultKeys.touchIdEnabledMessageKey)
    }
    
    /**
     Indicates if the intro demo has been displayed.
     */
    public class func didDisplayIntroDemo() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.introDemoKey)
    }
    
    /**
     Set if the intro demo has been displayed.
     
     - parameter displayed: True if displyed false if not.
     */
    public class func setDisplayedIntroDemo(_ displayed: Bool) {
        UserDefaults.standard.set(displayed, forKey: DefaultKeys.introDemoKey)
    }
    
    /**
     
     Sets if login info should be saved.
     
     - parameter remember: Indicates if credentials are saved.
     */
    public class func remeberLoginCredentials(_ remember: Bool)  {
        UserDefaults.standard.set(remember, forKey: DefaultKeys.rememberCredentialKey)
        
    }
    
    /**
     Indicates if the credentials are saved.
     */
    
    public class func isCredentialsSaved() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.rememberCredentialKey)
    }
    
    /**
     
     Sets when the app is loaded for the first time
     
     - parameter firsTime: Indicates the app has loaded for the first time
     
     */
    public class func firstTimeLoad(_ firstTime: Bool) {
        UserDefaults.standard.set(firstTime, forKey: DefaultKeys.firstTimeLoadKey)
    }
    
    /**
     
     Returns true if the app has been loaded for the first time.
     */
    public class func hasFirstTimeLoad() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.firstTimeLoadKey)
    }
    
    /**
     
     Sets when the app is loaded for the first time
     
     - parameter firsTime: Indicates the app has loaded for the first time
     
     */
    public class func setUserJustLoggedIn(justLoggedIn: Bool) {
        UserDefaults.standard.set(justLoggedIn, forKey: DefaultKeys.userJustLoggedIn)
    }
    
    /**
     
     Returns true if the app has been loaded for the first time.
     */
    public class func didUserJustLogIn() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.userJustLoggedIn)
    }
    
    /// Set A Bool UserDefault with key
    ///
    /// - Parameter key: Returns Bool value from UserDefault
    public subscript(key: String) -> Any? {
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
        
        get {
            return UserDefaults.standard.value(forKey: key)
        }
    }
    
}

