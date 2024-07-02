//
//  MulticastDelegate.swift
//  swift-toast
//
//  Created by 김건우 on 7/2/24.
//

import Foundation

class MulticastDelegate<T> {
    
    private let delegates: NSHashTable<AnyObject> = NSHashTable()
    
    func add(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    func remoe(_ delegateToRemove: T) {
        for delegate in delegates.allObjects.reversed() {
            if delegate === delegateToRemove as AnyObject {
                delegates.remove(delegate)
            }
        }
    }
    
    func invoke(_ invoacation: (T) -> Void) {
        for delegate in delegates.allObjects.reversed() {
            invoacation(delegate as! T)
        }
    }
    
}
