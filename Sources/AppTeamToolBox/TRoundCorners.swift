//
//  TRoundCorners.swift
//  AppTeamToolBox
//
//  Created by Max Nabokow on 12/30/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

struct CustomRoundedRectangle: Shape {
    var radius: CGFloat
    var corners: UIRectCorner = .allCorners

    @available(iOS 13.0, *)
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

@available(iOS 13.0, *)
extension View {
    func tRoundCorners(_ radius: CGFloat = 12, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(
            CustomRoundedRectangle(
                radius: radius,
                corners: corners
            )
        )
    }
}
