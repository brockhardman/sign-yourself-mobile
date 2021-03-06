

import Foundation

public extension Calendar {
    
    /// Returns a default Gregorian Calendar
    ///
    /// - Returns: Gregorian Calendar
    static func Default() -> Calendar {
        return Calendar(identifier: .gregorian)
    }
    
    
    /// Creates DateComponents from a given date
    ///
    /// - Parameter date: Date to retrieve data components from
    /// - Returns: DateComponents
    func components(of date: Date) -> DateComponents {
        return dateComponents(in: TimeZone.current, from: date)
    }
}
