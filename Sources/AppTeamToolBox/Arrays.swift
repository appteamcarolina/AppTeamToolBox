//
//  File.swift
//
//
//  Created by Max Nabokow on 11/18/21.
//

import Foundation

public extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

public extension Array where Element: Hashable {
    func uniqueElements() -> [Element] {
        var seen = Set<Element>()

        return self.compactMap { element in
            guard !seen.contains(element)
            else { return nil }

            seen.insert(element)
            return element
        }
    }
}
