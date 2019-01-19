
import Foundation

public extension DateComponents {
    
    /// This uses the Gregorian calendar from Device time zone.
    ///
    /// - Returns: Return DateComponents
    public static func Default() -> DateComponents {
         return DateComponents(calendar: Calendar.Default(), timeZone: TimeZone.current)
    }
    
    
    /// This uses the Gregorian calendar from UTC Time zone
    ///
    /// - Returns: Returns Date Components
    public static func UTC() -> DateComponents {
        return DateComponents(calendar: Calendar.Default(), timeZone: TimeZone(abbreviation: "UTC"))
    }
}
