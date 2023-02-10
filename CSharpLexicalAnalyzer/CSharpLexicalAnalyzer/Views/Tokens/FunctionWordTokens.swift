//
//  FunctionWordTokens.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import SwiftUI

enum FunctionWordTokens: String, Token {
    case classStatement = "class"           // 0
    case ifStatement = "if"                 // 1
    case elseStatement = "else"             // 2
    case whileStatement = "while"           // 3
    case integerStatement = "int"           // 4
    case floatStatement = "float"           // 5
    case doubleStatement = "double"         // 6
    case stringStatement = "string"         // 7
    case nameSpaceStatement = "namespace"   // 8
    case voidStatement = "void"             // 9
    case staticStatement = "static"         // 10
    case usingStatement = "using"           // 11
    case systemStatement = "System"         // 12
    case breakStatement = "break"           // 13
    
    
    static func isToken(_ s: String) -> Bool {
        Self.allCases.contains { $0.rawValue == s }
    }
    
    static func setToken(for s: String) -> FunctionWordTokens? {
        Self.allCases.first { $0.rawValue == s }
    }
    
    func encode() -> String {
        return "F_\(FunctionWordTokens.allCases.firstIndex(of: self)!)"
    }
    
    static func decode(_ s: String) -> FunctionWordTokens? {
        Self.allCases.first { $0.encode() == s }
    }
}


