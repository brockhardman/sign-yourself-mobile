//
//  UIColor+SYS.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 4/23/17.
//  Copyright © 2017 SignYourself. All rights reserved.
//

extension UIColor {
    public class var greenBackgroundColor : UIColor {
        return UIColor(red:0/255.0, green:150.0/255.0 ,blue:136.0/255.0 , alpha:1.00)
    }
    public class var navSelectedBackgroundColor : UIColor {
        return UIColor(red:7/255.0, green:168.0/255.0 ,blue:153.0/255.0 , alpha:1.00)
    }
    public class var navNormalBackgroundColor : UIColor {
        return UIColor(red:0/255.0, green:150.0/255.0 ,blue:136.0/255.0 , alpha:1.00)
    }
}

extension UIColor {
    
    //primary colors
    public class func nrgLightGreen() -> UIColor {
        return UIColor(hexString: "1F8C82")
    }
    
    /// Create a UIColor from a hexString
    ///
    /// - Parameter hexString: Hex string of color.
    public convenience init(hexString: String) {
        
        let hexString:NSString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) as NSString
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    ///  The shorthand three-digit hexadecimal representation of color. #RGB defines to the color #RRGGBB.
    ///
    /// - Parameters:
    ///   - hex3: Three-digit hexadecimal value
    ///   - alpha: 0.0 - 1.0. The default is 1.0
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// The shorthand four-digit hexadecimal representation of color with alpha. #RGBA defines to the color #RRGGBBAA.
    ///
    /// - Parameter hex4: Four-digit hexadecimal value.
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// The six-digit hexadecimal representation of color of the form #RRGGBB.
    ///
    /// - Parameters:
    ///   - hex6: Six-digit hexadecimal value.
    ///   - alpha:  0.0 - 1.0. The default is 1.0
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
    ///
    /// - Parameter hex8: Eight-digit hexadecimal value.
    public convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    ///  Hex string of a UIColor instance.
    ///
    /// - Parameter includeAlpha: Whether the alpha should be included.
    /// - Returns: returns the Hex string value of the color
    public func hexString(_ includeAlpha: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
}


