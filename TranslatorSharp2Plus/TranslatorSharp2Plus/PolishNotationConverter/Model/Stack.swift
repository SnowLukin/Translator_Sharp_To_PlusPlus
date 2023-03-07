//
//  Stack.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import Foundation

struct Stack<T> {
    private var elements: [T] = []
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        elements.popLast()
    }
    
    var top: T? {
        elements.last
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
}
