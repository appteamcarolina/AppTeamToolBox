//
//  MNQueueIterator.swift
//
//
//  Created by Max Nabokow on 4/14/22.
//

import Foundation

public struct MNQueueIterator<Element: Identifiable> {
    private(set) var items: [Element]
    private(set) var currentIndex: Int = 0

    public init(_ items: [Element]) {
        self.items = items
    }

    public var current: Element? {
        return items[safe: currentIndex]
    }

    public var count: Int { items.count }
    public var isEmpty: Bool { items.isEmpty }

    public mutating func setAllItems(to items: [Element]) {
        self.items = items
        fixIndexIfNeeded()
    }

    public mutating func prev() {
        currentIndex -= 1
        fixIndexIfNeeded()
    }

    public mutating func next() {
        currentIndex += 1
        fixIndexIfNeeded()
    }

    public mutating func insertAtCurrentIndex(_ element: Element) {
        items.insert(element, at: currentIndex)
    }

    @discardableResult
    public mutating func removeCurrent() -> Element? {
        guard !items.isEmpty else { return nil }

        defer { fixIndexIfNeeded() }
        return items.remove(at: currentIndex)
    }

    private mutating func fixIndexIfNeeded() {
        guard !items.isEmpty else { currentIndex = 0; return }

        if currentIndex >= items.endIndex {
            currentIndex = items.endIndex - 1
        } else if currentIndex < 0 {
            currentIndex = 0
        }
    }
}
