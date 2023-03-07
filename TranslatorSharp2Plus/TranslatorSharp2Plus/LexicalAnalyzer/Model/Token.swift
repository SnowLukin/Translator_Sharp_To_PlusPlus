//
//  Token.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 06.03.2023.
//

import Foundation

struct Token: Hashable, Comparable {
    let id: Int
    let value: String
    let type: TokenType
    
    var rawValue: String {
        switch type {
        case .separator:
            return value == " " ? "" : value
        default:
            return type.prefix + String(id) + " "
        }
    }
    
    var precedence: Int {
        switch value {
        case "*", "/":
            return 2
        case "+", "-":
            return 1
        default:
            return 0
        }
    }
    
    init(_ id: Int, _ value: String, _ type: TokenType) {
        self.id = id
        self.value = value
        self.type = type
    }
    
    init(_ id: Int, _ value: Character, _ type: TokenType) {
        self.id = id
        self.value = String(value)
        self.type = type
    }
    
    static func < (lhs: Token, rhs: Token) -> Bool {
        lhs.id < rhs.id
    }
}
