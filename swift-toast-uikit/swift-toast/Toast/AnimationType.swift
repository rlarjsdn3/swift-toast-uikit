//
//  AnimationType.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

extension Toast {
    
    public enum AnimationType {
        case slide(x: CGFloat, y: CGFloat)
        case fade(alpha: CGFloat)
        case scaleAndSlide(scaleX: CGFloat, scaleY: CGFloat, x: CGFloat, y: CGFloat)
        case scale(scaleX: CGFloat, scaleY: CGFloat)
        case custom(transformation: CGAffineTransform)
        case `default`
        
        // View의 시작 이동 위치 및 크기로 이동하는 메서드
        func apply(to view: UIView) {
            switch self {
            case .slide(let x, let y):
                view.transform = CGAffineTransform(scaleX: x, y: y)
                
            case .fade(let alpha):
                view.alpha = alpha
                
            case .scaleAndSlide(let scaleX, let scaleY, let x, let y):
                view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY).translatedBy(x: x, y: y)
                
            case .scale(let scaleX, let scaleY):
                view.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                
            case .custom(let transformation):
                view.transform = transformation
                
            case .default:
                break
            }
        }
        
        // View의 원래 위치로 이동하는 메서드
        func undo(from view: UIView) {
            switch self {
            case .slide, .scaleAndSlide, .scale, .custom:
                view.transform = .identity
                
            case .fade:
                view.alpha = 1.0
                
            case .`default`:
                break
            }
        }
    }
    
}
