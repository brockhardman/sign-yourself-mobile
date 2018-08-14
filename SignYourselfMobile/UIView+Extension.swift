//
//  UIView+Extension.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/11/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

extension UIView {
    func roundCorners(cornerRadius:CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    public class func fromNib<T : UIView>() -> T {
        let module = NSStringFromClass(self).components(separatedBy: ".").first!
        let stringToRemove = "\(module)."
        let className = String(describing: self).replacingOccurrences(of: stringToRemove, with: "")
        return Bundle.main.loadNibNamed(className, owner: nil, options: nil)![0] as! T
    }
    
    public class func fromNib<T : UIView>(bundle : Bundle) -> T {
        let module = NSStringFromClass(self).components(separatedBy: ".").first!
        let stringToRemove = "\(module)."
        let className = String(describing: self).replacingOccurrences(of: stringToRemove, with: "")
        return bundle.loadNibNamed(className, owner: nil, options: nil)![0] as! T
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
    }
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate as? CAAnimationDelegate
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    
}
extension UIView {
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}



