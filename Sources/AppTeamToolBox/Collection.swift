//
//  Collection.swift
//
//
//  Created by Max Nabokow on 7/1/21.
//

import Foundation

public extension Collection {
    /// Convenience function to avoid hard-to-read `!Collection.isEmpty` syntax
    /// - Returns: `True` if collection is not empty, `false` if it is.
    func isNotEmpty() -> Bool {
        !isEmpty
    }

    @available(iOS 15.0, *)
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Self.Element, Value>,
        order: SortOrder = .forward
    ) -> [Self.Element] {
        switch order {
        case .forward:
            return sorted(by: { $0[keyPath: keyPath] < $1[keyPath: keyPath] })
        case .reverse:
            return sorted(by: { $0[keyPath: keyPath] > $1[keyPath: keyPath] })
        }
    }
}
