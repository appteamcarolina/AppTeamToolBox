import SwiftUI

@available(macOS 11.0, *)
public extension View {
    /// Convenience function to apply accessibility modifiers to a SwiftUI `View`
    /// - Parameters:
    ///   - label: `accessibilityLabel` to apply
    ///   - hint: `accessibilityHint` to apply
    ///   - value: `accessibilityValue` to apply
    /// - Returns: `View` with specified accessibility modifiers. If all parameters `nil`, returns `View` excluded from accessibility.
    func accessibility(_ label: String?, hint: String?, value: String?) -> some View {
        if let label = label {
            return self.accessibilityLabel(label)
        }
        if let hint = hint {
            return self.accessibilityHint(hint)
        }
        if let value = value {
            return self.accessibilityValue(value)
        }
        return self.accessibilityHidden(true)
    }
}
