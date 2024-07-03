//
//  ToastConfiguration.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

public struct ToastConfiguration {
    
    // MARK: - Properties
    
    public let direction: Toast.Direction
    public let dismissables: [Toast.Dismssable]
    public let animationTime: TimeInterval
    public let enteringAnimation: Toast.AnimationType
    public let exitingAnimation: Toast.AnimationType
    public let background: Toast.Background
    public let allowToastOverlap: Bool
    
    public let view: UIView?
    
    
    // MARK: - Intializer
    
    public init(
        direction: Toast.Direction = .top,
        dismissables: [Toast.Dismssable] = [.time(time: 4.0), .swipe(direction: .natural)],
        animationTime: TimeInterval = 0.2,
        enteringAnimation: Toast.AnimationType = .default,
        exitingAnimation: Toast.AnimationType = .default,
        attachTo view: UIView? = nil,
        background: Toast.Background = .none,
        allowToastOverlap: Bool = true
    ) {
        self.direction = direction
        self.dismissables = dismissables
        self.animationTime = animationTime
        self.enteringAnimation = enteringAnimation.isDefualt ? Self.defaultEnteringAnimation(with: direction) : enteringAnimation
        self.exitingAnimation = exitingAnimation.isDefualt ? Self.defaultExitingAnimation(with: direction) : exitingAnimation
        self.view = view
        self.background = background
        self.allowToastOverlap = allowToastOverlap
    }
    
}


// MARK: - Extensions

private extension ToastConfiguration {
    
    private static func defaultEnteringAnimation(with direction: Toast.Direction) -> Toast.AnimationType {
        switch direction {
        case .top:
            return .custom(
                transformation: CGAffineTransform(scaleX: 0.9, y: 0.9).translatedBy(x: 0, y: -100)
            )
            
        case .bottom:
            return .custom(
                transformation: CGAffineTransform(scaleX: 0.9, y: 0.9).translatedBy(x: 0, y: 100)
            )
            
        case .center:
            return .custom(
                transformation: CGAffineTransform(scaleX: 0.5, y: 0.5)
            )
        }
    }
    
    private static func defaultExitingAnimation(with direction: Toast.Direction) -> Toast.AnimationType {
        self.defaultEnteringAnimation(with: direction)
    }
    
}



fileprivate extension Toast.AnimationType {
    
    var isDefualt: Bool {
        if case .default = self {
            return true
        }
        return false
    }
    
}
