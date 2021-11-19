//
//  File.swift
//  
//
//  Created by Max Nabokow on 11/18/21.
//

import CoreGraphics

public extension CGPoint {
    func distance(to other: CGPoint) -> CGSize {
        CGSize(width: other.x-x, height: other.y-y)
    }
}
