//
//  DividerTokens.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import Foundation

enum DividerTokens: String, Token {
    case whitespace = " "           // 0
    case startBracket = "{"         // 1
    case endBracket = "}"           // 2
    case startRoundBracket = "("    // 3
    case endRoundBracket = ")"      // 4
    case endl = "\n"                // 5
    case comma = ","                // 6
    case semicolon = ";"            // 7
    case quotes = "\""              // 8
    
    static func isToken(_ s: String) -> Bool {
        Self.allCases.contains { $0.rawValue == s }
    }
    
    static func setToken(for s: String) -> DividerTokens? {
        Self.allCases.first { $0.rawValue == s }
    }
    
    static func decode(_ s: String) -> DividerTokens? {
        Self.allCases.first { $0.encode() == s }
    }
    
    func encode() -> String {
        return "D_\(DividerTokens.allCases.firstIndex(of: self)!)"
    }
    
}
