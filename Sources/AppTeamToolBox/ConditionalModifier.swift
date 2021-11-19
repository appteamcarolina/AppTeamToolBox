//
//  ConditionalModifier.swift
//
//
//  Created by Max Nabokow on 12/21/20.
//

import SwiftUI

@available(iOS 13.0, *)
public extension View {
    @ViewBuilder
    /// Applies `View` modifer(s) only if `condition` is true
    /// - Returns: View with modifier in `Content` applied if `condition` is true
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}
