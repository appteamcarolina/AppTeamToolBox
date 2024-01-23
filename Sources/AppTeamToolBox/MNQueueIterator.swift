//
//  MNQueueIterator.swift
//
//
//  Created by Max Nabokow on 4/14/22.
//

import Foundation

public struct MNQueueIterator<Element: Identifiable> {
    // MARK: PRIVATE
    
    private var indexedItems: [(Int, String)] = []
    private var items: [Element]
    private var currIndex: Int?

    // MARK: PUBLIC

    public init(_ elements: [Element]) {
        items = elements
        currIndex = !items.isEmpty ? 0 : nil // When there are items, set to 0, else nil
        for index in 0...items.count{
            indexedItems.append((index,items[index]))
        }
        print(indexedItems)
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
        fixIndexIntoRange()
    }

    public mutating func next() {
        guard currIndex != nil else { return }
        currIndex! += 1
        fixIndexIntoRange()
    }

    public mutating func insertAtCurrentIndex(_ element: Element) {
        if currIndex == nil { currIndex = 0 }
        items.insert(element, at: currIndex!)
        fixIndexIntoRange()
    }
    
    public mutating func reorderItems(to elements: [Element]){
//        let unsortedArrayID = Set(elements.map { $0.id })
//        let sortedArray = items.filter { unsortedArrayID.contains($0.id) }
        
        items = elements
        // If there are items and index was previously invalid, start iterating from index zero
        if !items.isEmpty && currIndex == nil {
            currIndex = 0
        }
        print(items, "AFTERRRR_____\n\n\n\n")
        // If the new items array has less elements than before, make sure currentIndex isn't out of bounds
        fixIndexIntoRange()
        
    }

    public mutating func setAllItems(to elements: [Element]) {
        items = elements
        // If there are items and index was previously invalid, start iterating from index zero
        if !items.isEmpty && currIndex == nil {
            currIndex = 0
        }
        // If the new items array has less elements than before, make sure currentIndex isn't out of bounds
        fixIndexIntoRange()
    }
    

    @discardableResult
    public mutating func removeCurrent() -> Element? {
        guard !items.isEmpty, let currIndex else { return nil }

        let removedItem = items.remove(at: currIndex)

        fixIndexIntoRange() // Fix indices if currIndex is now invalid after the removal
        
        return removedItem
    }

    @discardableResult
    public mutating func removeAll() -> [Element] {
        // Make sure items isn't empty already
        guard !items.isEmpty else { return [] }

        let copy = items // Keep a copy of the items in the array to return later

        items.removeAll()

        fixIndexIntoRange()

        return copy
    }

    // MARK: Private Helpers

    private mutating func fixIndexIntoRange() {
        // Only proceed if the index was valid before
        // If it was invalid (nil), we don't know what to fix it to, so we keep it as is
        guard currIndex != nil else { return }

        // Only proceed if there are items, else invalidate index since there are no elements to index into
        guard !items.isEmpty else { currIndex = nil; return }

        // If we got here, there are definitely items and the index is non-nil
        // So, we adjust the index to make sure its not out of bounds

        let validRange = 0 ... items.endIndex - 1
        currIndex!.clipToRange(validRange)
    }
}
