

import Foundation
import CoreLocation

extension CLLocation {
    /// Returns true if specified location is close enough to this instance.
    /// Because of rounding error of Double, we should consider they are the same if they are close enough.
    /// Practically error below 0.0000001 (corresponds to 1cm on equator) is ignorable as far as coordinate is concerned.
    ///
    /// - Parameter otherLocation: Location to compare
    /// - Returns: True if specified location is close enough. False otherwise.
    open func coordinateIsEqual(to otherLocation: CLLocation?) -> Bool {
        guard let otherLocation = otherLocation else {
            return false
        }

        let latDelta = abs(coordinate.latitude - otherLocation.coordinate.latitude)
        let lngDelta = abs(coordinate.longitude - otherLocation.coordinate.longitude)

        return latDelta < 0.0000001 && lngDelta < 0.0000001
    }
}

