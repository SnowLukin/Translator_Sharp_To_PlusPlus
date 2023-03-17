//
//  SystemTables.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import Foundation

enum SystemTable {
    case divider
    case `operator`
    case keyword
    case separator
    
    static func getPrecedence(for value: String, with type: LexemeType) -> Int {
        switch type {
        case .functionCall, .arrayAddressCounter, .mark, .loopMark:
            return 0
        case .keyword:
            return precedenceTable[value, default: 10]
        case .divider, .operator:
            return precedenceTable[value, default: 10]
        default:
            return 100
        }
    }
    
    func getId(for value: String) -> Int? {
        switch self {
        case .divider:
            return dividers[value]
        case .operator:
            return operators[value]
        case .keyword:
            return keywords[value]
        case .separator:
            return separators[value]
        }
    }
    
    func getTable() -> [Lexeme] {
        switch self {
        case .divider:
            return dividers.map { Lexeme(id: $0.value, value: $0.key, type: .divider) }.sorted(by: { $0.id < $1.id })
        case .operator:
            return operators.map { Lexeme(id: $0.value, value: $0.key, type: .operator) }.sorted(by: { $0.id < $1.id })
        case .keyword:
            return keywords.map { Lexeme(id: $0.value, value: $0.key, type: .keyword) }.sorted(by: { $0.id < $1.id })
        case .separator:
            return []
        }
    }
}

extension SystemTable {
    
    private static var precedenceTable: [String:Int] {
        [
            "if" : 0,
            "while" : 0,
            "(" : 0,
            "[" : 0,
            "return" : 0,
            
            "]" : 1,
            ")" : 1,
            "{" : 1,
            "else" : 1,
            ";" : 1,
            
            "--" : 2,
            "++" : 2,
            
            "=" : 3,
            "+=" : 3,
            "-=" : 3,
            "*=" : 3,
            "/=" : 3,
            "%=" : 3,
            
            "<" : 3,
            ">" : 3,
            "<=" : 3,
            ">=" : 3,
            "!=" : 3,
            "==" : 3,
            
            "+" : 4,
            "-" : 4,
            
            "*" : 5,
            "/" : 5,
            "%" : 5,
        ]
    }
    
    private var dividers: [String:Int] {
        let symbols = ["{", "}", "(", ")", ",", ";", "\\", "[", "]"]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
    
    private var operators: [String:Int] {
        let symbols = ["+", "-", "*", "/", "%", "=", ">", "<", "!", "&", "|", "&&", "||", "++", "--", "+=", "-=", "/=", "*=", "%=", "<=", ">=", "==", "!="]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
    
    private var keywords: [String:Int] {
        let symbols = ["class", "if", "else", "while", "int", "float", "char", "string", "namespace", "void", "static", "using", "System", "break", "return"]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
    
    private var separators: [String:Int] {
        let symbols = [" ", "\n", "\t"]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
}
