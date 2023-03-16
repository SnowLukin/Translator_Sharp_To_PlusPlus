//
//  Stack.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import Foundation

struct Stack<T> {
    private var array = [T]()
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count
    }
    
    var top: T? {
        array.last
    }
    
    var bottom: T? {
        array.first
    }
    
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    mutating func pop() -> T? {
        array.popLast()
    }
    
    mutating func removeAll() {
        array = []
    }
}

extension Stack: Sequence {
    func makeIterator() -> AnyIterator<T> {
        var curr = self
        return AnyIterator { curr.pop() }
    }
}
