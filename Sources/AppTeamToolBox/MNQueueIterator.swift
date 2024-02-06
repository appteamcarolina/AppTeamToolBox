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
        items = elements
        currIndex = !items.isEmpty ? 0 : nil // When there are items, set to 0, else nil
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

    public mutating func insertAt(_ element: Element, index: Int) {
        if index >= count {
            items.append(element)
        } else {
            items.insert(element, at: index)
        }
        fixIndexIntoRange()
    }

    public mutating func insertAtCurrentIndex(_ element: Element) {
        if currIndex == nil { currIndex = 0 }
        items.insert(element, at: currIndex!)
        fixIndexIntoRange()
    }

    // Given a certain sorted array, this function determines whether to sort it based on a superset of a larger array, or an array simply in a different order.
    public mutating func reorderItems(to elements: [Element], index: Int) {
        // If the index is equal to 0, it indicates that the elements passed through as an argument is a larger array, and items is the subset of elements.
        if index == -1 {
            // This creates a dictionary that has keys of element ID and items of the index of the array
            var elementIndexDictionary = [Element.ID: Int]()

            for (index, object) in elements.enumerated() {
                elementIndexDictionary[object.id] = index
            }

            // Sorts 'items' based on their order in 'elementIndexDictionary', comparing indices to determine sort order, defaulting to 'false' for undefined indices.
            let sortedItems = items.sorted { obj1, obj2 -> Bool in
                guard let index1 = elementIndexDictionary[obj1.id], let index2 = elementIndexDictionary[obj2.id] else {
                    return false
                }
                return index1 < index2
            }
            items = sortedItems

        } else {
            // Maps each element in 'elements' to its 'id', creating an array of IDs.
            let unsortedArrayID = elements.map { $0.id }

            // Filters 'items' to include only those whose 'id' is found in 'unsortedArrayID'.
            let sortedArray = items.filter { unsortedArrayID.contains($0.id) }

            // Updates 'items' to be the filtered list, effectively removing any items not present in 'elements'.
            items = sortedArray
        }

        // If there are items and index was previously invalid, start iterating from index zero
        if !items.isEmpty && currIndex == nil {
            currIndex = 0
        }

        // If the index is not negative, it changes it to the index that's passed through the function.
        if index != -1 {
            currIndex = index
        }

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
