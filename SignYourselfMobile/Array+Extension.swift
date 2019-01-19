

import Foundation

extension Array {
    func removeDuplicates<T: Hashable>(byKey key: (Element) -> T)  -> [Element] {
        var result = [Element]()
        var seen = Set<T>()
        for value in self {
            if seen.insert(key(value)).inserted {
                result.append(value)
            }
        }
        return result
    }
}
