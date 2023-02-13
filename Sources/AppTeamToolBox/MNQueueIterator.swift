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
        guard let currIndex = currentIndex else { return nil }
        return items[safe: currIndex]
    }

    public var count: Int { items.count }
    public var isEmpty: Bool { items.isEmpty }

    public mutating func prev() {
        guard currIndex != nil else { return }
        currIndex! -= 1
        fixIndexIfNeeded()
    }

    public mutating func next() {
        guard currIndex != nil else { return }
        currIndex! += 1
        fixIndexIfNeeded()
    }

    public mutating func insertAtCurrentIndex(_ element: Element) {
        if currIndex == nil { currIndex = 0 }
        items.insert(element, at: currIndex!)
        fixIndexIfNeeded()
    }
    
    public mutating func setAllItems(to elements: [Element]) {
        self.items = elements
        fixIndexIfNeeded()
    }

    @discardableResult
    public mutating func removeCurrent() -> Element? {
        guard !items.isEmpty, let currIndex else { return nil }

        let removedItem = items.remove(at: currIndex)
        
        fixIndexIfNeeded() // Fix indices if currIndex is now invalid after the removal
        
        return removedItem
    }
    
    @discardableResult
    public mutating func removeAll() -> [Element] {
        // Make sure items isn't empty already
        guard !items.isEmpty else { return [] }
        
        let copy = items // Keep a copy of the items in the array to return later
        
        items.removeAll()
        
        fixIndexIfNeeded()
        
        return copy
    }
    
    // MARK: Private Helpers

    private mutating func fixIndexIfNeeded() {
        // Only proceed if the index was valid before
        // If it was invalid (nil), we don't know what to fix it to, so we keep it as is
        guard currIndex != nil else { return }
        
        // Only proceed if there are items, else invalidate index since there are no elements to index into
        guard !items.isEmpty else { currIndex = nil; return }
        
        // If we got here, there are definitely items and the index is non-nil
        // So, we adjust the index to make sure its not out of bounds
        
        let validRange = 0...items.endIndex-1
        currIndex!.clipToRange(validRange)
    }
}
