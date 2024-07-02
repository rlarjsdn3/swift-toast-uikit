//
//  ToastDelegate.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import Foundation

public protocol ToastDelegate: AnyObject {
    
    func willShowToast(_ toast: Toast)
    func didShowToast(_ toast: Toast)
    func willCloseToast(_ toast: Toast)
    func didCloseToast(_ toast: Toast)
    
}

extension ToastDelegate {
    
    func willShowToast(_ toast: Toast) { }
    func didShowToast(_ toast: Toast) { }
    func willCloseToast(_ toast: Toast) { }
    func didCloseToast(_ toast: Toast) { }
    
}
