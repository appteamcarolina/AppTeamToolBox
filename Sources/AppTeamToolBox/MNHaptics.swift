//
//  MNHaptics.swift
//  AppTeamToolBox
//
//  Created by Max Nabokow on 5/22/20.
//

#if os(iOS) || os(watchOS) || os(tvOS)
import SwiftUI
@available(iOS 13.0, *)
public class MNHaptics {
    private static let notificationGeneratoor = UINotificationFeedbackGenerator()
    private static let impactLight = UIImpactFeedbackGenerator(style: .light)
    private static let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    private static let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
    private static let impactSoft = UIImpactFeedbackGenerator(style: .soft)
    private static let impactRigid = UIImpactFeedbackGenerator(style: .rigid)
    private static let selectionGenerator = UISelectionFeedbackGenerator()

    public static let defaultDebounceInterval = 0.2

    /// Generates Light Impact Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func light(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactLight.impactOccurred()
            }
        } else {
            impactLight.impactOccurred()
        }
    }

    /// Generates Medium Impact Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func medium(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactMedium.impactOccurred()
            }
        } else {
            impactMedium.impactOccurred()
        }
    }

    /// Generates Heavy Impact Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func heavy(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactHeavy.impactOccurred()
            }
        } else {
            impactHeavy.impactOccurred()
        }
    }

    /// Generates Soft Impact Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func soft(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactSoft.impactOccurred()
            }
        } else {
            impactSoft.impactOccurred()
        }
    }

    /// Generates Rigid Impact Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func rigid(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                impactRigid.impactOccurred()
            }
        } else {
            impactRigid.impactOccurred()
        }
    }

    /// Generates Success Notification Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func success(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                notificationGeneratoor.notificationOccurred(.success)
            }
        } else {
            notificationGeneratoor.notificationOccurred(.success)
        }
    }

    /// Generates Warning Notification Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func warning(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                notificationGeneratoor.notificationOccurred(.warning)
            }
        } else {
            notificationGeneratoor.notificationOccurred(.warning)
        }
    }

    /// Generates Error Notification Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func error(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                notificationGeneratoor.notificationOccurred(.error)
            }
        } else {
            notificationGeneratoor.notificationOccurred(.error)
        }
    }

    /// Generates Selection Feedback
    /// - Parameters:
    ///   - debounced: set to `true` if several impacts should be debounced, default is `false`
    ///   - debounceInterval: set interval for debouncing, default is `0.2` (seconds)
    public static func selected(debounced: Bool = false, by debounceInterval: Double = defaultDebounceInterval) {
        if debounced {
            DispatchQueue.main.debounced(target: self, after: debounceInterval) {
                selectionGenerator.selectionChanged()
            }
        } else {
            selectionGenerator.selectionChanged()
        }
    }
}

// MARK: - DispatchQueue extensions for debouncing support

private extension DispatchQueue {
    func debounced(target: AnyObject, after delay: TimeInterval, perform: @escaping @convention(block) () -> Void) {
        let debounceId = DispatchQueue.debounceIdFor(target)
        if let existingWorkItem = DispatchQueue.workItems.removeValue(forKey: debounceId) {
            existingWorkItem.cancel()
        }
        let workItem = DispatchWorkItem {
            DispatchQueue.workItems.removeValue(forKey: debounceId)

            for ptr in DispatchQueue.weakTargets.allObjects {
                if debounceId == DispatchQueue.debounceIdFor(ptr as AnyObject) {
                    perform()
                    break
                }
            }
        }

        DispatchQueue.workItems[debounceId] = workItem
        DispatchQueue.weakTargets.addPointer(Unmanaged.passUnretained(target).toOpaque())

        asyncAfter(deadline: .now() + delay, execute: workItem)
    }
}

private extension DispatchQueue {
    static var workItems = [AnyHashable: DispatchWorkItem]()
    static var weakTargets = NSPointerArray.weakObjects()

    static func debounceIdFor(_ object: AnyObject) -> String {
        return "\(Unmanaged.passUnretained(object).toOpaque())." + String(describing: object)
    }
}
#endif
