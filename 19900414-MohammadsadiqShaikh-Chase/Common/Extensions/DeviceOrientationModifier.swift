//
//  DeviceOrientationModifier.swift
//  19900414-MohammadsadiqShaikh-Chase
//
//  Created by Mohammad Sadiq Shaikh on 13/09/23.
//

import SwiftUI

// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIInterfaceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                /// Used  interface orientation from Window scene so we get the correct orentation on app launch as well
                /// and whenever orentation is changed
                let scenes = UIApplication.shared.connectedScenes
                guard let windowScene = scenes.first as? UIWindowScene  else { return }
                action(windowScene.interfaceOrientation)
            }
    }
}

/// A View wrapper to use ViewModifier
extension View {
    func onRotate(perform action: @escaping (UIInterfaceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
