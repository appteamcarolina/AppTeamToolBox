//
//  Int+clipToRange.swift
//
//
//  Created by Max Nabokow on 2/13/23.
//

import Foundation

// Set of functions that add clipToRange functionality to the Int type

public extension Int {
    /**
     Adjusts ("clips") an integer to be within a given range (adjusts to closest integer in the range)
     - Parameters:
        - range: Closed range that the integer needs to be within
     - Returns: Updated version of itself. Does not mutate `self`.
     - Note: If `self` is already withing `range`, this function does nothing.
     */
    func clippedToRange(_ range: ClosedRange<Int>) -> Self {
        var adjusted = Swift.max(self, range.lowerBound) // lower bound adjustment
        adjusted = Swift.min(adjusted, range.upperBound) // upper bound adjustment
        return adjusted
    }

    /**
     Adjusts ("clips") an integer to be within a given range (adjusts to closest integer in the range).
     - Parameters:
        - int: inout Int to be clipped
        - range: Closed range that the integer needs to be within
     - Warning: Modifies the `int` parameter directly
     - Note: If self is already withing `range`, this function does nothing.
     - Remark: Static to the `Int` type, so call using `Int.clipToRange(...)`.
     */
    static func clipToRange(_ int: inout Int, range: ClosedRange<Int>) {
        int = int.clippedToRange(range)
    }

    /**
     Adjusts ("clips") the integer to be within a given range (adjusts to closest integer in the range)
     - Parameters:
        - range: Closed range that the integer needs to be within
     - Warning: Modifies `self` directly
     - Note: If self is already withing `range`, this function does nothing.
     */
    mutating func clipToRange(_ range: ClosedRange<Int>) {
        self = self.clippedToRange(range)
    }
}
