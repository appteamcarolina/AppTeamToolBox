//
//  File.swift
//  
//
//  Created by Max Nabokow on 4/14/22.
//

import SwiftUI

struct ForEachWithIndex<Element: Identifiable, Content: View>: View {
    let elements: [Element]
    @ViewBuilder let content: (Int, Element) -> Content

    var body: some View {
        ForEach(Array(elements.enumerated()), id: \.element.id) {
            content($0.offset, $0.element)
        }
    }
}
