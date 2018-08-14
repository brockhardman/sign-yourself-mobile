//
//  Utility.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/13/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation

public enum StringFormatType {
    case currency(decimalPlaces: Int)
    case percentage(decimalPlaces: Int)
    case decimal(decimalPlaces: Int)
}

public func LOG(_ message: String, object: Any?) {
    
    guard let value = object else {
        print(message)
        return
    }
    
    print("\(message): \(value)")
}

public let DEVICE = UIScreen.main.nativeBounds.height
public let IS_IPAD = UI_USER_INTERFACE_IDIOM() == .pad
public let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == .phone
public let IS_IPHONE_SM: Bool = (Device.iPhone4 || Device.iPhone5)
public let IS_IPAD_WITHOUT_TOUCHID: Bool = IS_IPAD && iPadTouchIDNotSupported()

/// Returns the storyboard with associated name
///
/// - Parameter name: Name of the storyboard
/// - Returns: Instance of UIStoryboard
public func storyBoard(name: String) -> UIStoryboard {
    return UIStoryboard(name: name, bundle: nil)
}

public func plistPath(_ name: String) -> String? {
    
    return Bundle.main.path(forResource: name, ofType: "plist")
}

public func plistPath(_ name: String, bundle: Bundle) -> String? {
    
    return bundle.path(forResource: name, ofType: "plist")
}

/// Present an alert with a title and message. User taps `OK` to dismiss
///
/// - Parameters:
///   - title: Title of the alert
///   - message: Message in the alert
///   - completion: Completion Block
public func presentAlert(title: String, message: String, completion: (()->())?) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let continueAction =  UIAlertAction(title: "OK", style: .default) { (action) in
        completion?()
    }
    
    alertController.addAction(continueAction)
    
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        
        topController.present(alertController, animated: true, completion: nil)
    }
}

public func presentAlert(_ title: String?, message: String?, okTitle: String?, cancelTitle: String?, okHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
    
    let notification = AlertMessage()
    
    if let alertTitle = title {
        notification.title = alertTitle
    }
    if let alertMessage = message {
        notification.message = alertMessage
    }
    
    if let alertOkTitle = okTitle {
        notification.okTitle = alertOkTitle
    }
    
    if let alertCancelTitle = cancelTitle {
        notification.cancelTitle = alertCancelTitle
    }
    notification.setOkHandler(okHandler)
    notification.setCancelHandler(cancelHandler)
    notification.show()
}

public func ShowProgress() {
    DispatchQueue.main.async {
        SignYourselfHud.default.show()
    }
}

public func HideProgress() {
    DispatchQueue.main.async {
        SignYourselfHud.default.dismiss()
    }
}

public func ShowProgress(over view: UIView) {
    DispatchQueue.main.async {
        SignYourselfHud.default.show(over: view)
    }
}

public func bounceAnimation() -> CAKeyframeAnimation {
    let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
    bounceAnimation.duration = TimeInterval(0.5)
    bounceAnimation.calculationMode = kCAAnimationCubic
    bounceAnimation.isRemovedOnCompletion = true
    
    return bounceAnimation
}

public func inactivityPeriodTooLong(_ previousDate: Date, currentDate: Date) -> Bool {
    
    let previousInterval = previousDate.timeIntervalSince1970
    let currentInterval = currentDate.timeIntervalSince1970
    
    let calculatedTime = (currentInterval - previousInterval) / 60
    
    return calculatedTime >= 15.0
}

public func versionNumber() -> String {
    return Bundle(identifier: Bundle.main.bundleIdentifier!)?.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
}

public func currentYear() -> Int {
    return Calendar.current.component(.year, from: Date())
}

/**
 
 Validates that the password matches all of the follwing requirements
 
 1 7 characters or more
 2 One or more uppercase letter
 3 One or more number
 4 No Special characters letters and numbers only
 
 - parameter password: Password to validate.
 
 */

public func validatePassword(_ password: String?) -> Bool {
    
    guard password != nil else {
        return false
    }
    
    guard password!.count >= 7 else {
        return false
    }
    
    guard  (password!.rangeOfCharacter(from: NSCharacterSet.decimalDigits, options: String.CompareOptions.numeric, range: nil) != nil) else {
        
        return false
    }
    
    guard (password!.rangeOfCharacter(from: NSCharacterSet.uppercaseLetters) != nil) else {
        
        return false
    }
    
    return true
}

public struct Device {
    public static let iPhone4: Bool = (UIScreen.main.nativeBounds.height == 960 && UIScreen.main.traitCollection.userInterfaceIdiom == .phone)
    public static let iPhone5: Bool = (UIScreen.main.nativeBounds.height == 1136 && UIScreen.main.traitCollection.userInterfaceIdiom == .phone)
    public static let iPhone: Bool = UIScreen.main.traitCollection.userInterfaceIdiom == .phone
    public static let iPhonePlus: Bool = (UIScreen.main.nativeBounds.height == 2208 && UIScreen.main.traitCollection.userInterfaceIdiom == .phone)
    public static let iPhoneX: Bool = (UIScreen.main.nativeBounds.height == 2436 && UIScreen.main.traitCollection.userInterfaceIdiom == .phone)
    public static let iPad: Bool = UIScreen.main.traitCollection.userInterfaceIdiom == .pad
    public static let iPadPro12: Bool = (UIScreen.main.nativeBounds.height == 2732 && UIScreen.main.traitCollection.userInterfaceIdiom == .pad)
    public static let iPadPro10: Bool = (UIScreen.main.nativeBounds.height == 2224 && UIScreen.main.traitCollection.userInterfaceIdiom == .pad)
}

public func iPadTouchIDNotSupported() -> Bool {
    
    //This is a list of devices that do not support TouchID for iPad
    let deviceList : [String] = ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad2,5", "iPad2,6", "iPad2,7", "iPad3,1", "iPad3,2", "iPad3,3", "iPad3,4", "iPad3,5", "iPad3,6", "iPad4,1", "iPad4,2", "iPad4,3", "iPad4,4", "iPad4,5", "iPad4,6"]
    
    return deviceList.contains(deviceIdentifier())
}

public func deviceIsIphone10orGreater() -> Bool {
    
    //This is a list of devices that are iPhone X, we check for iPhone X and above
    //["iPhone10,3", "iPhone10,6"]
    
    var isIphone10 : Bool = false
    let deviceMajorMinor = deviceIdentifier().components(separatedBy: "iPhone")
    if deviceMajorMinor.count > 1 {
        let device = deviceMajorMinor[1].components(separatedBy: ",")
        if let deviceMajor = device[0].integerValue {
            if deviceMajor >= 10 {
                if let deviceMinor = device[1].integerValue {
                    if deviceMajor > 10 || deviceMinor >= 3 {
                        isIphone10 = true
                    }
                }
            }
        }
    }
    
    return isIphone10
}

public func deviceIdentifier() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    return identifier
}
