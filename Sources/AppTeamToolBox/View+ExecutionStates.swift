//
//  View+ExecutionStates.swift
//  
//
//  Created by Beliz Yılmaz on 3/3/23.
//

import SwiftUI

// Functions for handling app state transitions.

public extension View {
    
    /// A notification posts when the app enters the background state and triggers this function call.
    func onAppWentToBackground(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            action()
        }
    }
    
    /// A notification posts during the app's transition from running in background state to becoming the active app
    /// and triggers this function call.
    func onAppCameToForeground(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            action()
        }
    }

    /// A notification posts when the app is no longer active and loses focus, and triggers this function call.
    func onAppBecameInactive(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            action()
        }
    }
    
    /// A notification posts when the app becomes active and triggers this function call.
    func onAppBecameActive(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            action()
        }
    }
    
    /// A notification posts when the application is about to terminate, i.e. when the user quits and
    /// triggers this function call.
    func onAppWillTerminate(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
            action()
        }
    }
}
