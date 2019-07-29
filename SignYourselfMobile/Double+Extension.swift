

import Foundation

public extension Double {
    
    // Normal Minimum Value of double
    static var minNormal: Double { return 2.2250738585072014e-308 }
    
    // Minimum value of double
    static var min: Double { return 4.9406564584124654e-324 }
    
    // Maximum value of double
    static var max: Double { return 1.7976931348623157e308 }
    
    static var metersInMile: Double {
        return 1609.34
    }
    
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    private static var commaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    
    var commaRepresentation: String {
        return Double.commaFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    /**
     Returns true if this Double value is the same as the nearest integer
     
     - Returns: True if self is the same as the nearest integer
     */
    func isInt() -> Bool {
        return floor(self) == self
    }
    
    /// In order to compare float values we need to compare with epsilon relative to an error tolerance.
    ///
    /// - Parameters:
    ///   - a: First float number.
    ///   - b: Second float number.
    ///   - epsilon: Releative Error. So if you want 99.99% accuracy you would pass in 0.00001.
    /// - Returns: True if both float numbers are relative to each other based on the releative error.
    func compare(to value: Double, epsilon: Double) -> Bool {
        let absA = abs(self)
        let absB = abs(value)
        let diff = abs(self - value)
        
        if (self == value) {
            
            return true
        } else if (self == 0 || value == 0 || diff < Double.minNormal) {
            
            return diff < (epsilon * Double.minNormal)
        } else {
            
            return (diff / (absA + absB)) < epsilon
        }
    }
    
    ///  Returns Double as a string
    var stringValue: String {
        return String(self)
    }
    
    /// Returns the Integer Value rounded down to the nearst whole number
    var integerValue: Int? {
        return Int(floor(self))
    }
    
    /// Returns Boolean value of double
    var boolValue: Bool {
        return self != 0
    }
    
    /// Convencience Methods for comparing a Double with a default epsilon value of 0.00000000000001
    ///
    /// - Parameters:
    ///   - a: First float number.
    ///   - b: Second float number.
    /// - Returns: True if both float numbers are relative to each other based on the releative error.
    func compare(to value: Double) -> Bool {
        return self.compare(to: value, epsilon: 0.00000000000001)
    }
    
    private static let superscriptedIntegers: [String: String] = [
        "1": "¹",
        "2": "²",
        "3": "³",
        "4": "⁴",
        "5": "⁵",
        "6": "⁶",
        "7": "⁷",
        "8": "⁸",
        "9": "⁹",
        "0": "⁰"
    ]
    /// Convenience method for superscripting the first decimal point in a double
    ///
    /// - Returns: String with the first decimal superscripted
    func superscriptedDecimalString() -> String {
        let stringValueSplit = String(format: "%g", self).split(separator: ".")
        if stringValueSplit.count == 2 {
            if let superscript = Double.superscriptedIntegers[String(stringValueSplit[1])] {
                return String(format: "%g", floor(self)) + superscript
            }
            //Something has gone wrong if you hit this line
            return String(format: "%g", self)
        } else {
            return String(stringValueSplit[0])
        }
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

public protocol OptionalDouble{}
extension Double: OptionalDouble{}
public extension Optional where Wrapped: OptionalDouble {
    
    ///  Returns Double as a string
    var stringValue: String? {
        
        guard self != nil else {
            return nil
        }
        
        return (self as! Double).stringValue
    }
    
    /// Returns the Integer Value rounded down to the nearst whole number
    var integerValue: Int? {
        
        guard self != nil else {
            return nil
        }
        return (self as! Double).integerValue
    }
    
    /// Returns Boolean value of double
    var boolValue: Bool {
        
        guard self != nil else {
            return false
        }
        
        return (self as! Double).boolValue
    }
}




