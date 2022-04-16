//
//  ViewEffects.swift
//
//
//  Created by Max Nabokow on 4/16/22.
//

import SwiftUI

@available(iOS 15.0, *)
public extension View {
    func foregroundLinearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint
    ) -> some View {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(
                self
            )
        }
    }
}
