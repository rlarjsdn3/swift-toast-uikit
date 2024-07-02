//
//  Direction.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import Foundation

extension Toast {
    
    public enum Direction {
        case top, bottom, center
    }
    
    public enum DismissSwipeDirection: Equatable {
        case toTop,
             toBottom,
             natural
        
        func shouldApply(_ delta: CGFloat, direction: Direction) -> Bool {
            switch self {
            case .toTop:
                return delta <= 0
            case .toBottom:
                return delta >= 0
            case .natural:
                switch direction {
                case .top:
                    return delta <= 0
                case .bottom:
                    return delta >= 0
                case .center:
                    return delta <= 0
                }
            }
        }
    }
    
}
