//
//  ReliantFont.swift
//  Reliant 
//
//  Created by Woodall, Kristopher on 5/19/16.
//  Copyright © 2016 Woodall, Kristopher. All rights reserved.
//

import UIKit

public enum FontName: String {
    case regular = "Effra-Regular"
    case bold =  "Effra-Bold"
    case medium = "Effra-Medium"
    case light = "Effra-Light"
    case italic = "Effra-Italic"
    case lightItalic = "Effra-LightItalic"
    
    init(name: String) {
        self.init(rawValue: name)!
    }
}


/// Identifies the type of Effra Font
///
/// - bold: Effra Bold
/// - boldItalic: Effra Bold italic
/// - heavy: Effra heavy
/// - heavyItalic: Effra heavy italic
/// - italic: Effra italic
/// - light: Effra light
/// - lightItalic: Effra light italic
/// - medium: Effra medium
/// - mediumItalic: Effra medium italic
/// - regular: Effra regular

public enum EffraFont: String {
    case bold = "Effra-Bold"
    case boldItalic = "Effra-BoldItalic"
    case heavy = "Effra-Heavy"
    case heavyItalic = "Effra-HeavyItalic"
    case italic = "Effra-Italic"
    case light = "Effra-Light"
    case lightItalic = "Effra-LightItalic"
    case medium = "Effra-Medium"
    case mediumItalic = "Effra-MediumItalic"
    case regular = "Effra-Regular"
}

extension UIFont  {
    
    public class func defaultFont(size: CGFloat) -> UIFont {
        return UIFont.effra(type: .regular, size: size)
    }
    
    public class func defaultBoldFont(size: CGFloat) -> UIFont {
        return UIFont.effra(type: .bold, size: size)
    }
    
    /// Create a UIFont from a dictionary of values
    ///
    /// - Parameter dictionary: Dictionary of name and font size.
    public convenience init?(dictionary: [String: Any]) {
        let name = dictionary["fontName"]//.String!
        let size = dictionary["fontSize"]//.Number!).doubleValue)
        
        self.init(name: name as! String, size: size as! CGFloat)
    }
    
    
    /// Creates a Effra Font
    ///
    /// - Parameters:
    ///   - type: Type of EffraFont
    ///   - size: Size of Font
    /// - Returns: Effra font if found else system font with size.
    public class func effra(type: EffraFont, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.rawValue, size: size) else {
            //dLog("ReliantFramework: Unable to load font", object: type.rawValue)
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }

    public class func font(withDictionary dictionary: [String: AnyObject]) -> UIFont {
        
        let name = dictionary["fontName"] as! String
        let size = CGFloat((dictionary["fontSize"] as! NSNumber).doubleValue)
        
        return UIFont.fontFromName(name, size: size)
    }
    
    public class func fontFromName(_ name: String, size: CGFloat) -> UIFont {
        let fontName = FontName(name: name)
        switch fontName {
        case .regular: return UIFont.defaultFont(size: size)
        case .bold: return UIFont.defaultBoldFont(size: size)
        case .medium: return UIFont.effra(type: .medium, size: size)
        case .light: return UIFont.effra(type: .light, size: size)
        case .italic: return UIFont.effra(type: .italic, size: size)
        case .lightItalic: return UIFont.effra(type: .lightItalic, size: size)
        }
    }
}
