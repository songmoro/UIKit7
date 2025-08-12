//
//  MyObservable.swift
//  UIKit7
//
//  Created by 송재훈 on 8/11/25.
//

import Foundation

@propertyWrapper
final class MyObservable<T> {
    private var handler: ((T) -> Void)?
    private var value: T
    
    var projectedValue: MyObservable<T> {
        get {
            return self
        }
        set {
            self.wrappedValue = newValue.value
        }
    }
    
    var wrappedValue: T {
        get {
            return value
        }
        set {
            self.value = newValue
            handler?(newValue)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(handler: @escaping (T) -> Void) {
        handler(value)
        self.handler = handler
    }
}
