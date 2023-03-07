//
//  Queue.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import Foundation

struct Queue<T> {
    private var elements: [T] = []
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        return elements.isEmpty ? nil : elements.removeFirst()
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
}
