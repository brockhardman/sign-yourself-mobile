
import Foundation

public extension DateComponents {
    
    /// This uses the Gregorian calendar from Device time zone.
    ///
    /// - Returns: Return DateComponents
    static func Default() -> DateComponents {
         return DateComponents(calendar: Calendar.Default(), timeZone: TimeZone.current)
    }
    
    
    /// This uses the Gregorian calendar from UTC Time zone
    ///
    /// - Returns: Returns Date Components
    static func UTC() -> DateComponents {
        return DateComponents(calendar: Calendar.Default(), timeZone: TimeZone(abbreviation: "UTC"))
    }
}
