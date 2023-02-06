//
//  FunctionWordTokens.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import SwiftUI

enum FunctionWordTokens: String, Token {
    case ifStatement = "if"
    case elseStatement = "else"
    case whileStatement = "while"
    case integerStatement = "int"
    case floatStatement = "float"
    case doubleStatement = "double"
    case stringStatement = "string"
    
    static func isToken(_ s: String) -> Bool {
        Self.allCases.contains { $0.rawValue == s }
    }
    
    static func setToken(for s: String) -> FunctionWordTokens? {
        Self.allCases.first { $0.rawValue == s }
    }
    
    func encode() -> String {
        return "F_\(FunctionWordTokens.allCases.firstIndex(of: self)!)"
    }
}


