//
//  Dismissables.swift
//  swift-toast
//
//  Created by 김건우 on 7/3/24.
//

import Foundation

extension Toast {
    
    public enum Dismssable: Equatable {
        case tap,
             longPress,
             time(time: TimeInterval),
             swipe(direction: DismissSwipeDirection)
    }
    
}
