//
//  File.swift
//
//
//  Created by Max Nabokow on 4/14/22.
//

import SwiftUI

private struct IconWidthKey: PreferenceKey {
    static var defaultValue: CGFloat? { nil }

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        switch (value, nextValue()) {
        case (nil, let next): value = next
        case (_, nil): break
        case (.some(let current), .some(let next)): value = max(current, next)
        }
    }
}

extension IconWidthKey: EnvironmentKey {}

private extension EnvironmentValues {
    var iconWidth: CGFloat? {
        get { self[IconWidthKey.self] }
        set { self[IconWidthKey.self] = newValue }
    }
}

private struct IconWidthModifier: ViewModifier {
    @Environment(\.iconWidth) var width

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy in
                Color.clear
                    .preference(key: IconWidthKey.self, value: proxy.size.width)
            })
            .frame(width: width)
    }
}

struct EqualIconWidthLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon.modifier(IconWidthModifier())
            configuration.title
        }
    }
}

public struct EqualIconWidthDomain<Content: View>: View {
    let content: Content
    @State var iconWidth: CGFloat? = nil

    public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .environment(\.iconWidth, iconWidth)
            .onPreferenceChange(IconWidthKey.self) { self.iconWidth = $0 }
            .labelStyle(EqualIconWidthLabelStyle())
    }
}
