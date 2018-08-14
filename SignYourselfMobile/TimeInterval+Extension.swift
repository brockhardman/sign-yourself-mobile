//
//  TimeInterval+Extension.swift
//  Utility
//
//  Created by Woodall, Kristopher on 3/15/17.
//  Copyright © 2017 Reliant. All rights reserved.
//

import Foundation

/// Converts seconds into relative time.
///
/// - day: Seconds into days.
/// - hour: Seconds into hours.
/// - minute: Seconds into Minutes.
public enum Conversion {
    case day
    case hour
    case minute
}

public extension TimeInterval {
    /// Converts seconds into either number of days, hours, or minutes as a Double
    ///
    /// - Parameter conversion: Type of conversion from seconds.
    /// - Returns: Converted time
    public func convert(to type: Conversion) -> Double {
        switch type {
        case .day: return self / (60 * 60 * 24)
        case .hour: return self / (60 * 60)
        case .minute: return self / 60
        }
    }
}
