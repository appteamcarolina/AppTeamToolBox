//
//  MNBlurView.swift
//  AppTeamToolBox
//
//  Created by Max Nabokow on 7/4/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct MNBlurView: UIViewRepresentable {
    public typealias UIViewType = UIView
    let style: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style = .systemMaterial) {
        self.style = style
    }
    
    public func makeUIView(context: UIViewRepresentableContext<MNBlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        view.insertSubview(blurView, at: 0)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<MNBlurView>) {}
}
