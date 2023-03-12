//
//  Lexema.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

struct Lexema: Hashable {
    private(set) var id: Int
    private(set) var value: String
    private(set) var type: LexemaType
    
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

extension Lexema: SystemTables {
    var precedence: Int {
        switch type {
        case .functionCall, .arrayAddressCounter, .mark:
            return 0
        case .keyword:
            return precedenceTable[value, default: 10]
        case .divider, .operator:
            return precedenceTable[value, default: 10]
        default:
            return 100
        }
    }
}

extension Lexema: Comparable {
    static func < (lhs: Lexema, rhs: Lexema) -> Bool {
        lhs.precedence < rhs.precedence
    }
}

extension Lexema {
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
