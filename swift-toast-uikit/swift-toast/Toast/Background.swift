//
//  Background.swift
//  swift-toast
//
//  Created by 김건우 on 7/3/24.
//

import UIKit

extension Toast {
    
    public enum Background: Equatable {
        case none,
             color(color: UIColor = defaultImageTint.withAlphaComponent(0.25))
    }
    
}
