//
//  DividerTokens.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import Foundation

enum DividerTokens: String, Token {
    case whitespace = " "
    case startBracket = "{"
    case endBracket = "}"
    case startRoundBracket = "("
    case endRoundBracket = ")"
    case endl = "\n"
    case comma = ","
    case semicolon = ";"
    case quotes = "\""
    
    static func isToken(_ s: String) -> Bool {
        Self.allCases.contains { $0.rawValue == s }
    }
    
    static func setToken(for s: String) -> DividerTokens? {
        Self.allCases.first { $0.rawValue == s }
    }
    
    func encode() -> String {
        return "D_\(DividerTokens.allCases.firstIndex(of: self)!)"
    }
}
