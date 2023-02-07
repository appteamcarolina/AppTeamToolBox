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
    private var currIndex: Int?

    // MARK: PUBLIC
    
    public init(_ elements: [Element]) {
        self.items = elements
        currIndex = 0
    }
    
    public var elements: [Element] { items }
    public var currentIndex: Int? { currIndex }

    public var current: Element? {
        if(currIndex == nil) { return nil }
        return items[safe: currIndex!]
    }

    public var count: Int { items.count }
    public var isEmpty: Bool { items.isEmpty }

    public mutating func prev() {
        if(currIndex == nil) { return }
        currIndex! -= 1
        fixIndexIfNeeded()
    }

    public mutating func next() {
        if(currIndex == nil) { return }
        currIndex! += 1
        fixIndexIfNeeded()
    }

    public mutating func insertAtCurrentIndex(_ element: Element) {
        if(currIndex == nil) { currIndex = 0 }
        items.insert(element, at: currIndex!)
        fixIndexIfNeeded()
    }
    
    public mutating func setAllItems(to elements: [Element]) {
        self.items = elements
        fixIndexIfNeeded()
    }

    @discardableResult
    public mutating func removeCurrent() -> Element? {
        guard !items.isEmpty else { return nil }

        defer { fixIndexIfNeeded() }
        if(currIndex == nil) { return nil }
        return items.remove(at: currIndex!)
    }
    
    @discardableResult
    public mutating func removeAll() -> [Element]? {
        guard !items.isEmpty else { return nil }
        currIndex! = -1
        defer { items.removeAll() }
        return items
    }
    
    // MARK: Private Helpers

    private mutating func fixIndexIfNeeded() {
        guard !items.isEmpty else { currIndex = nil; return }
        if(currIndex == nil) { return }
        if currIndex! >= items.endIndex {
            currIndex! = items.endIndex - 1
        } else if currIndex! < 0 {
            currIndex! = 0
        }
    }
}
