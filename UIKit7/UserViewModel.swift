//
//  UserViewModel.swift
//  UIKit7
//
//  Created by 송재훈 on 8/8/25.
//

import Foundation

public enum UserViewModelAction {
    case none
    case load
    case remove(Int)
    case reset
    case add(String, Int)
}

final class UserViewModel {
    private(set) var list: [Person] = [] {
        didSet {
            reload?()
        }
    }
    
    var reload: (() -> Void)?
    
    var action = UserViewModelAction.none {
        didSet {
            switch action {
            case .none:
                break
            case .remove(let index):
                remove(index)
            case .load:
                load()
            case .reset:
                removeAll()
            case let .add(name, age):
                add(name, age)
            }
        }
    }
    
    public func infomation(rowAt row: Int) -> String {
        let person = list[row]
        
        return "\(person.name), \(person.age)세"
    }
    
    private func load() {
        list = [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
    
    private func removeAll() {
        list.removeAll()
    }
    
    private func remove(_ index: Int) {
        list.remove(at: index)
    }
    
    private func add(_ name: String, _ age: Int) {
        list.append(Person(name: name, age: age))
    }
}
