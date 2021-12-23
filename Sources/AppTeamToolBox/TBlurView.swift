//
//  BlurView.swift
//  Trove
//
//  Created by Max Nabokow on 7/4/20.
//  Copyright © 2020 Maximilian Nabokow. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct TBlurView: UIViewRepresentable {
    public typealias UIViewType = UIView
    var style: UIBlurEffect.Style = .systemMaterial
    
    public func makeUIView(context: UIViewRepresentableContext<TBlurView>) -> UIView {
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
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<TBlurView>) {}
}
