//
//  View+ExecutionStates.swift
//  
//
//  Created by Beliz Yılmaz on 3/3/23.
//

import SwiftUI

// Functions for reactively running closures during UIApplication state transitions.

public extension View {
    
    /// Runs `action` whenever the application entered the background state
    func onAppWentToBackground(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            action()
        }
    }
    
    /// Runs `action` whenever the application enters the foreground state
    func onAppCameToForeground(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            action()
        }
    }

    /// Runs `action` whenever the application is no longer active and loses focus.
    func onAppBecameInactive(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            action()
        }
    }
    
    /// Runs `action` whenever the application becomes active.
    func onAppBecameActive(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            action()
        }
    }
    
    /// Runs `action` whenever the application is about to terminate, i.e. when the user quits.
    func onAppWillTerminate(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
            action()
        }
    }
}
