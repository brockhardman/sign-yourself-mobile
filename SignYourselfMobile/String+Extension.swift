

import Foundation
import UIKit

/// Returns an empty string
public let EMPTY_STRING: String = ""

/// Used to indicate a missing field if nothing returned from API
public let MISSING_STRING = "--"

public extension String {
  
    var first: String {
        return String(prefix(1))
    }
    
    var last: String {
        return String(suffix(1))
    }
    
    var uppercaseFirst: String {
        return first.uppercased() + String(dropFirst())
    }
    
    /// Returns Integer value of String if found.
    var integerValue: Int? {
        return Int(self)
    }
    
    /// Return Double value of String if found
    var doubleValue: Double? {
        return Double(self)
    }

    /// Checks if String contains `Yes` or `No` and returns a bool value.
    var boolValue: Bool {
        return (self).lowercased() == ("yes") || (self).lowercased() == ("true") || (self).lowercased() == ("1") || (self).lowercased() == "y" || (self).lowercased() == "success" || (self).lowercased() == "s"
    }
    
    /// Return literal string into a date provided the format of the date and the DateFormatter.
    ///
    /// - Parameters:
    ///   - format: The format of the date
    ///   - formatter: ateFormatter defaults to UTC time zone if not specified.
    /// - Returns: Date from literal string
    func date(format: String, formatter: DateFormatter = DateFormatter.Default()) -> Date? {
        
        guard self != EMPTY_STRING else {
            return nil
        }
        
        formatter.dateFormat = format
        
        return formatter.date(from: self)
    }
    
    /// Filters string for only characters that match a provided list.
    ///
    /// - Parameter characterList: List of characters
    /// - Returns:  Filtered string that matches the characters
    func filter(characterList: String) -> String {
        return filter({ characterList.contains($0) }).reduce("", { $0 + String($1) })
    }
    
    /// Insert character at provided index of string.
    ///
    /// - Parameters:
    ///   - character: Character that will inserted into string.
    ///   - index: Where in the string the character will be inserted.
    /// - Returns: New string with added character.
    func insert(string: String, index: Int) -> String {
        return String(self.prefix(index)) + string + String(self.suffix(self.count-index))
    }
    
    /// Returns the size of the String.
    ///
    /// - Parameters:
    ///   - font: The font of the string that will be used to calculate the size of the string.
    ///   - size: The limit size the string will fit into.
    ///   - alignment: If the text is center, left, or right justified.
    ///   - lineBreak: The line break mode of the string.
    /// - Returns: The size of the string.
    func size(with font: UIFont, boundingSize: CGSize, alignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byWordWrapping) -> CGSize {
        
        let textStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = alignment
        textStyle.lineBreakMode = lineBreakMode
        
        let textFontAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: textStyle]
        
        let textFrame: CGRect = self.boundingRect(with: boundingSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: textFontAttributes, context: nil)
        
        return textFrame.size
    }
    
    /// Formats string as a string sentenced cased. The first word is only capitalized.
    ///
    /// - Returns: Sentenced cased string.
    func sentenceCase() -> String {
        return self.components(separatedBy: " ").enumerated().compactMap() { (index, value) in
            
            guard index != 0 else {
                return value.lowercased().uppercaseFirst
            }
            
            return value.lowercased()
            
            }.joined(separator: " ")
    }
    
    
    /// Helper method to find a substring of a string using Integer values rather then Index values
    ///
    /// - Parameters:
    ///   - start: Start index of search
    ///   - end: End index of search
    /// - Returns: Return substring from range.
    func subString(from start: Int, to end: Int? = nil) -> String {
        
        let maximum = count
        var startIndex = start < 0 ? self.endIndex : self.startIndex
        let startOffset = min(maximum, max(-1 * maximum, start))
        startIndex = index(startIndex, offsetBy: startOffset)
        
        guard let end = end, end > start, end <= maximum else {
            // end is the end of the current string
            return String(self[startIndex...self.endIndex])
        }
        
        let endIndex = index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }
    
    init?(htmlEncodedString: String) {
        self.init()
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            self = htmlEncodedString
            return
        }
        
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error)")
            self = htmlEncodedString
        }
    }

}


public protocol OptionalString{}
extension String: OptionalString{}
public extension Optional where Wrapped: OptionalString {
    
    /// Returns Integer value of String if found.
    var integerValue: Int? {
        
        guard self != nil  else {
            return nil
        }
        
        return (self as! String).integerValue
    }
    
    /// Return Double value of String if found
    var doubleValue: Double? {
        
        guard self != nil  else {
            return nil
        }

        return (self as! String).doubleValue
    }
        
    /// Checks if String returns a bool value. 
    var boolValue: Bool {
        
        guard self != nil  else {
            return false
        }
        
        return (self as! String).boolValue
    }
    
    /// Checks to see if the string is a Valid String. It is not nil and is not empty
    var isValid: Bool {
       return (self is String) && !(self as! String).isEmpty
    }
    
    /// Return literal string into a date provided the format of the date and the DateFormatter.
    ///
    /// - Parameters:
    ///   - format: The format of the date
    ///   - formatter: DateFormatter defaults to UTC time zone if not specified.
    /// - Returns: Date from literal string
    func date(format: String, formatter: DateFormatter = DateFormatter.Default()) -> Date? {
        
        guard self != nil  else {
            return nil
        }
        
        let string = self as! String
        guard string != EMPTY_STRING else {
            return nil
        }
        
        formatter.dateFormat = format
        
        return formatter.date(from: string)
    }
}
