//
//  Toast.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

// TODO: - Toast 코드 작성하기
public class Toast {
    
    public let view: ToastView
    
    
    public static var defaultImageTint: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    
    
    
    public private(set) var config: ToastConfiguration
    
    
    public required init(view: ToastView, config: ToastConfiguration) {
        self.config = config
        self.view = view
        
    }
    
}


extension Toast {
    
    public enum Dismssable: Equatable {
        case tap,
             longPress,
             time(time: TimeInterval),
             swipe(direction: DismissSwipeDirection)
    }
    
    public enum Background: Equatable {
        case none,
             color(color: UIColor = defaultImageTint.withAlphaComponent(0.25))
    }
    
}

extension Toast: Equatable {
    
    public static func == (lhs: Toast, rhs: Toast) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
}
