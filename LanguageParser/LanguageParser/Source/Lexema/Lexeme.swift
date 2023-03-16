//
//  Lexeme.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

struct Lexeme: Hashable {
    private(set) var id: Int
    private(set) var value: String
    private(set) var type: LexemeType
    
    var rawValue: String {
        switch type {
        case .separator:
            return value == " " ? "" : value
        case .arrayAddressCounter, .functionCall, .mark:
            return value + " "
        case .conditional, .goto:
            return type.rawValue
        default:
            return type.rawValue + "_" + String(id) + " "
        }
    }
}

extension Lexeme {
    var precedence: Int {
        SystemTable.getPrecedence(for: value, with: type)
    }
}

extension Lexeme: Comparable {
    static func < (lhs: Lexeme, rhs: Lexeme) -> Bool {
        lhs.precedence < rhs.precedence
    }
}

extension Lexeme {
    var isOpeningSquareBracket: Bool {
        type == .divider && value == "["
    }
    
    var isClosingSquareBracket: Bool {
        type == .divider && value == "]"
    }
    
    var isOpeningRoundBracket: Bool {
        type == .divider && value == "("
    }
    
    var isClosingRoundBracket: Bool {
        type == .divider && value == ")"
    }
    
    var isOpeningBracket: Bool {
        type == .divider && value == "{"
    }
    
    var isClosingBracket: Bool {
        type == .divider && value == "}"
    }
}
