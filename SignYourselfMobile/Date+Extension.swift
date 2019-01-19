

import Foundation

/// Date component to increase or decrease date by. If DateCalendarComponents is nill will default to the system default
/// caledar and date components
//
/// - day: Number of days to increase/decrease
/// - week: Number of weeks to increase/decrease
/// - month: Number of months to increase/decrease
/// - year: Number of years from to increase/decrease

public enum DateAdjustment {
    case seconds(add: Int)
    case minutes(add: Int)
    case hour(add: Int)
    case day(add: Int)
    case week(add: Int)
    case month(add: Int)
    case year(add: Int)
}


/// Date extensions adds calendar, date components, and date formatter settings for all dates. Each setting defaults to the system time and time zone.
///
/// If a new setting is required change the setting on the date instance.
/// It is important to note that if you do not adjust each instance's required settings it will default to what you have set previously.
///
/// In other words, if you change a particular instance date settings for the next date set you will need to also change 
/// that instance's setting else will take the last instance's settings
///
/// For Example: 
///
/// let firstDate = Date()
/// var formatter = DateComponents()
/// formatter.timeZone = TimeZone(abbreviation: "HST")
/// firstDate.components = formatter
///
/// Creating a second date will be set on Pacific/Honolulu time else you change that instances settings.
///
/// let secondDate = Date()
/// secondDate.component == firstDate.component
///
///
/// This is done because typically in an application you will be using the same time zone and settings for all dates
/// You now only have to set it once and all other dates will reflect the settings.
///
public extension Date {
    
    /// Returns Current Date. 
    /// If you need to change the Date system settings you can adjust here and all other dates
    /// will reflect the changes made. 
    /// If a particular date needs a different setting then you need to change that instance date
    static var current: Date = Date()
    
    private struct DateAttributes  {
        static var calendar: Calendar?
        static var components: DateComponents?
        static var formatter: DateFormatter?
    }
    
    /// The Calendar attribute of the date. This defaults to the gregorian calendar. 
    /// In order to change you can change on the instance of the date. 
    
    /***  NOTE: Changing on one instance of Date will change for all other instances ***/
    
    var calendar: Calendar? {
        set {
            DateAttributes.calendar = newValue
        }
        get {
            return DateAttributes.calendar
        }
    }
    
    /// The DateComponents attribute of the date. This defaults to the device timezone.
    /// In order to change you can change on the instance of the date.
    
    /***  NOTE: Changing on one instance of Date will change for all other instances ***/
    var components: DateComponents? {
        set {
            DateAttributes.components = newValue
        }
        get {
            return DateAttributes.components
        }
    }
    
    /// The DateFormatter attribute of the date. This defaults to the device timezone.
    /// In order to change you can change on the instance of the date.
    
    /***  NOTE: Changing on one instance of Date will change for all other instances ***/
    var formatter: DateFormatter? {
        set {
            DateAttributes.formatter = newValue
        }
        get {
            return DateAttributes.formatter
        }
    }
    
    /// Returns UTC Date that is equivalent with the current stystem date.
    public static var UTC: Date {
        let currentDate = Date()
        let timeDifference = TimeZone.current.secondsFromGMT()
        return currentDate + TimeInterval(timeDifference)
    }
    
    /// Converts date into a string provided the format and Dateformatter which defaults to UTC time
    ///
    /// - Parameters:
    ///   - format:  The format of the date string
    ///   - formatter: DateFormatter defaults to UTC Date format if not provided.
    /// - Returns: Formatted string
    public func string(format: String) -> String {
        
        let formater = self.formatter ?? DateFormatter.Default()
        formater.dateFormat = format

        return formater.string(from: self)
    }
    
    /// Checks to see if the year is a leap year.
    ///
    /// - Returns: True if year is a leap year
    public func isLeapYear() -> Bool {
        
        if let year = Int(self.string(format: "YYYY")) {
            return (year % 100 != 0) && (year % 4 == 0) || year % 400 == 0
        }
        
        return false
    }
    
    
    /// Checks to is the date month is a leap month
    ///
    /// - Parameter info: Date info used to calculate the date this is optional
    /// - Returns: Returns true if curent month is a leap month
    public func isLeapMonth() -> Bool {
        
        let calendar = self.calendar ?? Calendar.Default()
        let component = calendar.dateComponents([Calendar.Component.month], from: self)
        
        return component.isLeapMonth ?? false
    }
    
    
    /// Gets the number of the date month
    ///
    /// - Parameter info: Date info used to calculate the date this is optional
    /// - Returns: Number of the month
    public func monthNumber() -> Int {
        
        let calendar = self.calendar ?? Calendar.Default()
        let component = calendar.dateComponents([Calendar.Component.month], from: self)
        
        return component.month!
    }
    
    /// Gets the week number in the year from the date
    ///
    /// - Parameter info: Date info used to calculate the date this is optional
    /// - Returns: Returns the week number
    public func weekNumber() -> Int {
        
        let calendar = self.calendar ?? Calendar.Default()
        let component = calendar.dateComponents([Calendar.Component.weekOfYear], from: self)
        
        return component.weekOfYear!
    }
    
    /// Returns number of days in the corresponding month
    ///
    /// - returns: Number of days in the corresponding month
    func daysInMonth() -> Int {
        
        let calendar = self.calendar ?? Calendar.Default()
        let components = calendar.components(of: self)
    
        let month = components.month!
        
        if month == 2 {
            if isLeapYear() {
                return 29
            } else {
                return 28
            }
        }
        if [4,6,9,11].contains(month) {
            return 30
        }
        
        return 31
    }

    /// Checks to see if the date is within a specified range
    ///
    /// - Parameters:
    ///   - startDate: The start of the date range
    ///   - endDate: The end of the date range
    /// - Returns: True if the date falls any where in the range inculding the start and end date.
    public func inRange(of startDate: Date, to endDate: Date) -> Bool {
        guard self == startDate else {
            return true
        }
        
        guard self == endDate else {
            return true
        }
        
        let greaterThenStartDate = self > startDate
        let lessThenEndDate = self < endDate
        
        return (greaterThenStartDate && lessThenEndDate)
    }
    
    /// Start of month
    ///
    /// - returns: First day of the month of this date instance
    func startOfMonth() -> Date {
        let calendar = self.calendar ?? Calendar.Default()
        let components = calendar.components(of: self)
        
        let surplusDays = components.day! - 1
        
        return self - TimeInterval(surplusDays * 24 * 60 * 60)
    }
    
    /// End of month
    ///
    /// - returns: Last day of the month of this date instance
    func endOfMonth() -> Date {
        
        let firstDayOfNextMonth = (self + .month(add: 1)).startOfMonth()
        
        return (firstDayOfNextMonth + .day(add: -1)).endOfDay()
    }
    
    /// Start of year
    ///
    /// - returns: First day of the year
    func startOfYear() -> Date {
        let calendar = self.calendar ?? Calendar.Default()
        let components = calendar.components(of: self)
        
        let year = components.year!
        let dateString = String(format: "%02d%02d%04d", 1, 1, year)
        
        return dateString.date(format: "MMddyyyy")!
    }
    
    /// End of year
    ///
    /// - returns: Last day of the year
    func endOfYear() -> Date {
        
        let calendar = self.calendar ?? Calendar.Default()
        let components = calendar.components(of: self)
        
        let year = components.year!
        let dateString = String(format: "%02d%02d%04d", 12, 31, year)
        
        return dateString.date(format: "MMddyyyy")!
    }
    
    /// Start of week
    ///
    /// - returns: First day of the week of this date instance
    func startOfWeek() -> Date {
        
        let calendar = self.calendar ?? Calendar.Default()
        let components = calendar.components(of: self)
        let surplusDays = components.weekday! - 1
        
        return self - TimeInterval(surplusDays * 24 * 60 * 60)
    }

    /// End of week
    ///
    /// - returns: Last day of the week of this date instance
    public func endOfWeek() -> Date {
        
        let calendar = self.calendar ?? Calendar.Default()
        let components = calendar.components(of: self)
        let additionalDays = 7 - components.weekday!
        
        return self + TimeInterval(additionalDays * 24 * 60 * 60)
    }
    
    
    /// End of Day
    ///
    /// - Returns: Returns End of day Date based on current date.
    public func endOfDay() -> Date {
        let calendar = self.calendar ?? Calendar.Default()
        
        var components = calendar.components(of: self)
        components.hour = 23
        components.minute = 59
        components.second = 59

        return calendar.date(from: components)!
    }
    
    public var yearValue: Int {
        return Calendar.current.component(.year, from: self)
    }
}

public protocol OptionalDate{}
extension Date: OptionalDate{}
public extension Optional where Wrapped: OptionalDate {
    
    /// Converts date into a string provided the format and Dateformatter which defaults to UTC time
    ///
    /// - Parameters:
    ///   - format:  The format of the date string
    ///   - formatter: DateFormatter defaults to UTC Date format if not provided.
    /// - Returns: Formatted string
    public func string(format: String, formatter: DateFormatter = DateFormatter.Default()) -> String? {
        
        guard self != nil  else {
            return nil
        }
        
        formatter.dateFormat = format
        
        return formatter.string(from: self! as! Date)
    }
}

/// Used to increase or decrease the number of date components from the date.
///
/// - Parameters:
///   - lhs: Date that will be adjusted
///   - rhs: Date component to adjust
/// - Returns: New date
public func +(lhs: Date, rhs: DateAdjustment) -> Date {
    
    switch rhs {
        
    case .seconds(let number):
        
        let calendar = lhs.calendar ?? Calendar.Default()
        var components = lhs.components ?? DateComponents.Default()
        components.second = number
        
        return calendar.date(byAdding: components, to: lhs)!
        
    case .minutes(let number):
        
        let calendar = lhs.calendar ?? Calendar.Default()
        var components = lhs.components ?? DateComponents.Default()
        components.minute = number
        
        return calendar.date(byAdding: components, to: lhs)!
        
    case .hour(let number):
        
        let calendar = lhs.calendar ?? Calendar.Default()
        var components = lhs.components ?? DateComponents.Default()
        components.hour = number
        
        return calendar.date(byAdding: components, to: lhs)!

    case .day(let number):
        
        let calendar = lhs.calendar ?? Calendar.Default()
        var components = lhs.components ?? DateComponents.Default()
        components.day = number
    
        return calendar.date(byAdding: components, to: lhs)!
        
    case .week(let number):
        
        let calendar = lhs.calendar ?? Calendar.Default()
        return calendar.date(byAdding: Calendar.Component.day, value: (7 * number), to: lhs)!
        
    case .month(let number):
        
        let calendar = lhs.calendar ?? Calendar.Default()
        var components = lhs.components ?? DateComponents.Default()
        components.month = number
        
        return calendar.date(byAdding: components, to: lhs)!
        
    case .year(let number):
        
        let calendar = lhs.calendar ?? Calendar.Default()
        var components = lhs.components ?? DateComponents.Default()
        components.year = number
        
        return calendar.date(byAdding: components, to: lhs)!
    }
}
