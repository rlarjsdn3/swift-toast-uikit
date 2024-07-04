//
//  AppleToastView.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

public class AppleToastView: UIView, ToastView {
    
    // MARK: - Properties
    
    private let viewConfig: ToastViewConfiguration
    
    private let child: UIView
    
    private var toast: Toast?
    
    
    // MARK: - Intializer
    
    public init(
        child: UIView,
        viewConfig: ToastViewConfiguration = ToastViewConfiguration()
    ) {
        self.viewConfig = viewConfig
        self.child = child
        super.init(frame: .zero)
        
        addSubview(child)
    }
    
    
    // MARK: - Helpers
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        self.toast = nil
    }
    
    public func createView(for toast: Toast) {
        self.toast = toast
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: viewConfig.minWidth),
            heightAnchor.constraint(equalToConstant: viewConfig.minHeight),
            leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: 10),
            trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: -10),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
        
        switch toast.config.direction {
        case .top:
            topAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.topAnchor,
                constant: 0 + viewConfig.yOffset
            ).isActive = true
        case .bottom:
            bottomAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.bottomAnchor,
                constant: 0 + viewConfig.yOffset
            ).isActive = true
        case .center:
            centerYAnchor.constraint(
                equalTo: superview.layoutMarginsGuide.centerYAnchor,
                constant: 0 + viewConfig.yOffset
            ).isActive = true
        }
        
        addSubviewConstraints()
        DispatchQueue.main.async {
            self.style()
        }
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        UIView.animate(withDuration: 0.5) {
            self.style()
        }
    }

    
    private func style() {
        layoutIfNeeded()
        clipsToBounds = true
        layer.zPosition = 999 // ⭐️
        layer.cornerRadius = viewConfig.cornerRadius ?? frame.height / 2
        if #available(iOS 12.0, *) {
            backgroundColor = traitCollection.userInterfaceStyle == .light ? viewConfig.lightBackgroundColor : viewConfig.darkBackgroundColor
        } else {
            backgroundColor = viewConfig.lightBackgroundColor
        }
        
        if viewConfig.isShowingShadow {
            addShadow()
        }
    }
    
    private func addSubviewConstraints() {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            child.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            child.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            child.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
    
    private func addShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
