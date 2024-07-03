//
//  ToastQueueDelegate.swift
//  swift-toast
//
//  Created by 김건우 on 7/3/24.
//

import Foundation

public protocol ToastQueueDelegate: AnyObject {
    
    func willShowAnyToast(_ toast: Toast, queuedToasts: [Toast]) -> Void
    func didShowAnyToast(_ toast: Toast, queuedToasts: [Toast]) -> Void
    
}

extension ToastQueueDelegate {
    
    public func willShowAnyToast(_ toast: Toast, queuedToasts: [Toast]) { }
    public func didShowAnyToast(_ toast: Toast, queuedToasts: [Toast]) { }
    
}
