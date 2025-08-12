//
//  Observable.swift
//  UIKit7
//
//  Created by 송재훈 on 8/11/25.
//

import Foundation

final class Observable<T> where T: Equatable {
    private var handler: ((T) -> Void)?
    
    var value: T {
        didSet {
            handler?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    init(value: T, handler: @escaping (T) -> Void) {
        self.value = value
        self.handler = handler
    }
    
    func bind(handler: @escaping (T) -> Void) {
        handler(value)
        self.handler = handler
    }
}
