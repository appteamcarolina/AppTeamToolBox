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
        !self.isEmpty
    }
}
