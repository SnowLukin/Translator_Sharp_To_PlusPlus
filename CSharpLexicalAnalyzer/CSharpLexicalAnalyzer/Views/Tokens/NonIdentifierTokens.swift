//
//  NonIdentifierTokens.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 09.02.2023.
//

import Foundation

enum NonIdentifierToken: String, Token {
    
    case dollar = "$"
    case sharp = "#"
    case dot = "."
    case comma = ","
    case doubleDot = ":"
    case dotComma = ";"
    case slash = "\\"
    case backSlash = "/"
    case straightLine = "|"
    case chevronLeft = "<"
    case chevronRight = ">"
    // name these later
    case weird1 = "`"
    case weird2 = "~"
    case weird4 = "^"
    case weird5 = "&"
    
    static func isToken(_ s: String) -> Bool {
        s.contains { char in
            NonIdentifierToken.allCases.contains { $0.rawValue == String(char) }
        } ||
        s.contains(where: { DividerTokens.isToken(String($0)) }) ||
        s.contains(where: { OperationTokens.isToken(String($0)) })
    }
    
    static func setToken(for s: String) -> NonIdentifierToken? {
        NonIdentifierToken.allCases.first { $0.rawValue == s }
    }
    
    func encode() -> String {
        return "Error"
    }
}
