//
//  MNRoundCorners.swift
//  AppTeamToolBox
//
//  Created by Max Nabokow on 12/30/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import SwiftUI

public struct CustomRoundedRectangle: Shape {
    var radius: CGFloat
    var corners: UIRectCorner = .allCorners

    @available(iOS 13.0, *)
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

@available(iOS 13.0, *)
public extension View {
    /// View function to apply rounding to individual corners of a View
    /// - Parameters:
    ///   - radius: radius to be for the corner
    ///   - corners: set of corners to be rounded, use `.allCorners` to apply to all 4
    /// - Returns: `View` with specified corners rounded. Warning: This makes the `View` clip its content to its new shape
    func mnRoundCorners(_ radius: CGFloat = 12, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(
            CustomRoundedRectangle(
                radius: radius,
                corners: corners
            )
        )
    }
}
#endif
