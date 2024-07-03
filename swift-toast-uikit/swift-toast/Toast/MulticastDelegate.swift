//
//  MulticastDelegate.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import Foundation

final class MulticastDelegate<T> {
    
    private let delegates: NSHashTable<AnyObject> = NSHashTable()
    
    func add(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    func remove(_ delegateToRemove: T) {
        for delegate in delegates.allObjects.reversed() {
            if delegate === delegateToRemove as AnyObject {
                delegates.remove(delegate)
            }
        }
    }
    
    func invoke(_ invocation: (T) -> Void) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
    
}
