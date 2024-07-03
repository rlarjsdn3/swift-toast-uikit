//
//  ToastQueue.swift
//  swift-toast
//
//  Created by 김건우 on 7/3/24.
//

import Foundation

public class ToastQueue {
    
    // MARK: - Properties
    
    private var queue: [Toast]
    private var multicast = MulticastDelegate<ToastQueueDelegate>()
    private var isShowing = false
    
    
    // MARK: - Intializer
    
    public init(toasts: [Toast] = [], delegates: [ToastQueueDelegate] = []) {
        self.queue = toasts
        delegates.forEach(multicast.add)
    }
    
    
    // MARK: - Enqueue
    
    public func enqueue(_ toast: Toast) {
        queue.append(toast)
    }
    
    public func enqueue(_ toasts: [Toast]) {
        let size = queue.count
        toasts.forEach { queue.append($0) }
        
        if size == 0 && isShowing {
            show()
        }
    }
    
    
    // MARK: - Dequeue
    
    public func dequeue(_ toastToDequeue: Toast) {
        let index: Int? = queue.firstIndex(where: { $0 === toastToDequeue })
        
        if let index {
            queue.remove(at: index)
        }
    }
    
    
    // MARK: - Show
    
    public func show() {
        show(index: 0)
    }
    
    private func show(index: Int, after: Double = 0.0) -> Void {
        isShowing = true
        if queue.isEmpty {
            return
        }
        
        let toast: Toast = queue.remove(at: index)
        let delegate = QueuedToastDelegate(queue: self)
        
        multicast.invoke { $0.willShowAnyToast(toast, queuedToasts: queue) }
        
        toast.addDelegate(delegate: delegate)
        toast.show(after: after)
    }
    
    
    // MARK: - Size
    
    public func size() -> Int {
        return queue.count
    }
    
    
    // MARK: - QueuedToastDelegate
    
    private class QueuedToastDelegate: ToastDelegate {
        
        private var queue: ToastQueue
        
        public init(queue: ToastQueue) {
            self.queue = queue
        }
        
        public func didCloseToast(_ toast: Toast) {
            queue.multicast.invoke { $0.didShowAnyToast(toast, queuedToasts: queue.queue) }
            queue.show(index: 0, after: 0.5)
        }
        
    }
    
    
}


