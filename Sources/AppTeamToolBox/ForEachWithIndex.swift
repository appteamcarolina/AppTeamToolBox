//
//  File.swift
//
//
//  Created by Max Nabokow on 4/14/22.
//

import SwiftUI

public struct ForEachWithIndex<Element: Identifiable, Content: View>: View {
    let elements: [Element]
    @ViewBuilder let content: (Int, Element) -> Content

    public var body: some View {
        ForEach(Array(elements.enumerated()), id: \.element.id) {
            content($0.offset, $0.element)
        }
    }
}
