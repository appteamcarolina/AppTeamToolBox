//
//  File.swift
//  
//
//  Created by Beliz Yılmaz on 3/3/23.
//

import SwiftUI

extension View {
    func onAppCameToForeground(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            action()
        }
    }

    func onAppMovedFromActiveToInactive(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            action()
        }
    }
    
    func onAppWentToBackground(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            action()
        }
    }
    
    func onAppBecameActive(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            action()
        }
    }
    
    func onAppWillTerminate(perform action: @escaping () -> Void) -> some View {
        self.onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
            action()
        }
    }
}
