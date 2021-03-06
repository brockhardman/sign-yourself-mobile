

import Foundation

public extension DateFormatter {
    
    /// Returns A Date formatter with UTC timezone. This is used a lot due to the time returned from API.
    ///
    /// - Returns: Returns instance of DateFormatter set in UTC time zone. 
    static func UTC() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return formatter
    }
    
    
    /// Returns a DateFormatter with the device current timezone
    ///
    /// - Returns: Instance of DateFormatter
    static func Default() -> DateFormatter {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        
        return formatter
    }
    
    static var rewardsDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yyyy"
        return dateFormatter
    }()
    
    static var planExpirationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMM"
        return dateFormatter
    }()
    
    static var planExpirationDateStringFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/yyyy"
        return dateFormatter
    }()
}
