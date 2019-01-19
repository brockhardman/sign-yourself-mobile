//
//  String+Extension.swift
//  RELFramework
//
//  Created by Kristopher Woodall on 1/28/16.
//  Copyright © 2016 Kristopher Woodall. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func begins(with string: String, caseSensitive: Bool = true) -> Bool {
        let prefixEndIndex = index(startIndex, offsetBy: string.count)
        if caseSensitive {
            return self[...prefixEndIndex] == string
        } else {
            return self[...prefixEndIndex].lowercased() == string.lowercased()
        }
    }
    
    func ends(with string: String, caseSensitive: Bool = true) -> Bool {
        
        guard (count - string.count) > 0 else {
            return false
        }
        
        let postfixStartIndex = index(startIndex, offsetBy: count - string.count)
        if caseSensitive {
            return self[...postfixStartIndex] == string
        } else {
            return self[...postfixStartIndex].lowercased() == string.lowercased()
        }
    }
    
    func dropFirst(string: String, caseSensitive: Bool = true) -> String {
        guard begins(with: string, caseSensitive: caseSensitive) else {
            return self
        }
        
        let prefixEndIndex = index(startIndex, offsetBy: string.count)
        return String(self[...prefixEndIndex])
    }
    
    func dropLast(string: String, caseSensitive: Bool = true) -> String {
        guard ends(with: string, caseSensitive: caseSensitive) else {
            return self
        }
        
        let postfixEndIndex = index(startIndex, offsetBy: count - string.count)
        return String(self[...postfixEndIndex])
    }

    var isValidUSZipCode: Bool {
        let predicate = NSPredicate(format: "SELF matches %@", "\\d{5,5}")
        return predicate.evaluate(with: self)
    }

    func attributeString(boldWords: [String]?, colorWords: [String]?, color: UIColor = UIColor.black, textFont: UIFont = UIFont.effra(type: .light, size: 15), boldFont: UIFont = UIFont.effra(type: .bold, size: 15), alignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byWordWrapping) -> NSAttributedString? {
        
        let allBoldWords = boldWords ?? [String]()
        let allColorWords = colorWords ?? [String]()
        
        let attributedString = NSMutableAttributedString(string: self)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = alignment
        
        let textRange = NSRange(location: 0, length: self.count)
        let nsText = self as NSString
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: textRange)
        
        allBoldWords.forEach { (subString) in
            let subStringRange = nsText.range(of: subString)
            attributedString.addAttributes([NSAttributedString.Key.font: boldFont], range: subStringRange)
        }
        
        allColorWords.forEach { (subString) in
            let subStringRange = nsText.range(of: subString)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color], range: subStringRange)
        }
        
        return attributedString
    }

    func removingLeadingZeros() -> String {
        var counter = 0
        var stop = false
        (0..<self.count).forEach({ (i) in
            if stop == true {
                return
            }
            let c = subString(from: i, to: i+1)
            if c != "0" {
                stop = true
                return
            }
            counter += 1
        })
        return subString(from: counter)
    }

    //
    // Format any US phonenumbers (10 digits) into following standard format
    //
    //     (XXX)YYY-ZZZZ
    //
    public func formattingPhoneNumbers() -> String {
        let regExp = try? NSRegularExpression(pattern: "([0-9]{3,3}).*([0-9]{3,3}).*([0-9]{4,4})", options: .caseInsensitive)
        guard let match = regExp?.firstMatch(in: self, options: .anchored, range: NSMakeRange(0, self.count)), match.numberOfRanges > 3 else {
            // Cannot format. Just return as it is
            return self.formatting1800PhoneNumbers()
        }

        let areaCode = (self as NSString).substring(with: match.range(at: 1))
        let secondCode = (self as NSString).substring(with: match.range(at: 2))
        let thirdCode = (self as NSString).substring(with: match.range(at: 3))

        return "(\(areaCode))\u{00a0}\(secondCode)-\(thirdCode)"
    }
    
    //
    // Format any US phonenumbers (10 digits) into following standard format
    //
    //     1(XXX)YYY-ZZZZ
    //
    public func formatting1800PhoneNumbers() -> String {
        let regExp = try? NSRegularExpression(pattern: "([1]{1,1})-.*([0-9]{3,3})-.*([0-9]{3,3})-.*([0-9]{4,4})", options: .caseInsensitive)
        guard let match = regExp?.firstMatch(in: self, options: .anchored, range: NSMakeRange(0, self.count)), match.numberOfRanges > 3 else {
            // Cannot format. Just return as it is
            return self
        }
        
        let intCode = (self as NSString).substring(with: match.range(at: 1))
        let areaCode = (self as NSString).substring(with: match.range(at: 2))
        let secondCode = (self as NSString).substring(with: match.range(at: 3))
        let thirdCode = (self as NSString).substring(with: match.range(at: 4))
        
        return "\(intCode)\u{00a0}(\(areaCode))\u{00a0}\(secondCode)-\(thirdCode)"
    }
    
    var html2AttributedString: NSAttributedString? {
        do {

            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes:nil)
        } catch {
            return nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func uppercaseFirstLetter() -> String {

        return self.components(separatedBy: CharacterSet.whitespaces.union(.newlines)).enumerated().compactMap() { (index, value) in
        
            return value.sentenceCase()
            
            }.joined(separator: " ")

    }
}




