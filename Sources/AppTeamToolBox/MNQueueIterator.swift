//
//  MNQueueIterator.swift
//
//
//  Created by Max Nabokow on 4/14/22.
//

import Foundation

public struct MNQueueIterator<Element: Identifiable> {
    // MARK: PRIVATE
    private var items: [Element]
    private var currIndex: Int = 0

    // MARK: PUBLIC
    
    public init(_ elements: [Element]) {
        self.items = elements
    }
    
    public var elements: [Element] { items }
    public var currentIndex: Int { currIndex }

    public var current: Element? {
        return items[safe: currIndex]
    }

    public var count: Int { items.count }
    public var isEmpty: Bool { items.isEmpty }

    public mutating func prev() {
        currIndex -= 1
        fixIndexIfNeeded()
    }

    public mutating func next() {
        currIndex += 1
        fixIndexIfNeeded()
    }

    public mutating func insertAtCurrentIndex(_ element: Element) {
        items.insert(element, at: currIndex)
        fixIndexIfNeeded()
    }

    @discardableResult
    public mutating func removeCurrent() -> Element? {
        guard !items.isEmpty else { return nil }

        defer { fixIndexIfNeeded() }
        return items.remove(at: currIndex)
    }
    
    @discardableResult
    public mutating func removeAll() -> [Element]? {
        guard !items.isEmpty else { return nil }
        currIndex = -1
        defer { items.removeAll() }
        return items
    }
    
    // MARK: Private Helpers

    private mutating func fixIndexIfNeeded() {
        guard !items.isEmpty else { currIndex = -1; return }

        if currIndex >= items.endIndex {
            currIndex = items.endIndex - 1
        } else if currIndex < 0 {
            currIndex = 0
        }
    }
}
