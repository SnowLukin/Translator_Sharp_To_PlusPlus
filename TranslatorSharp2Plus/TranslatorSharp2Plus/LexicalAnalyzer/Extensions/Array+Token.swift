//
//  Array+Token.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import Foundation

extension Array where Element == Token {
    
    var stringRepresentation: String {
        self.map { $0.rawValue }.joined()
    }
    
    var valueRepresentation: String {
        self.map { $0.value + ($0.type == .separator ? "" : " ") }.joined()
    }
    
    func find(for str: String) -> Token? {
        self.first(where: { $0.value == str })
    }
    
    mutating func safeAdd(_ str: String, _ type: TokenType) -> Token {
        guard let token = self.find(for: str) else {
            let token = Token(self.count, str, type)
            self.append(token)
            return token
        }
        return token
    }
    
    static func from(_ queue: Queue<Token>) -> [Token] {
        var queue = queue
        var outputArray: [Token] = []
        while let token = queue.dequeue() {
            outputArray.append(token)
        }
        return outputArray
    }
}
