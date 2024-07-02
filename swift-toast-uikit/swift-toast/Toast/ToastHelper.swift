//
//  ToastHelper.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import UIKit

class ToastHelper {
    
    public static func topController() -> UIViewController? {
        if var topController = keyWindow()?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    private static func keyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            for scene in UIApplication.shared.connectedScenes {
                guard
                    let windowScene = scene as? UIWindowScene
                else { continue }
                
                if windowScene.windows.isEmpty {
                    continue
                }
                
                guard
                    let window = windowScene.windows.first(where: { $0.isKeyWindow })
                else { continue }
                
                return window
            }
            return nil
        } else {
            return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        }
    }
    
}
