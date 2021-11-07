//
//  File.swift
//
//
//  Created by Max Nabokow on 11/7/21.
//

import CoreGraphics

public extension CGRect {
    /// Convenience property to get the center of the `CGRect` as a `CGPoint`
    var center: CGPoint {
        let x = origin.x + (size.width / 2)
        let y = origin.y + (size.height / 2)

        return CGPoint(x: x, y: y)
    }
}
