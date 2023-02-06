//
//  OperationTokens.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import SwiftUI

enum OperationTokens: String, Token {
    case plus = "+"
    case minus = "-"
    case multiplier = "*"
    case divider = "/"
    case remainder = "%"
    case equalTo = "="
    
    case doublePlus = "++"
    case doubleMinus = "--"
    case plusEqualTo = "+="
    case minusEqualTo = "-="
    case divideEqualTo = "/="
    case multiplyEqualTo = "*="
    case remaindEqualTo = "%="
    
    case less = "<"
    case lessOrEqual = "<="
    case more = ">"
    case moreOrEqual = ">="
    case isEqual = "=="
    case notEqual = "!="
    
    
    static func isToken(_ s: String) -> Bool {
        Self.allCases.contains { $0.rawValue == s }
    }
    
    static func setToken(for s: String) -> OperationTokens? {
        Self.allCases.first { $0.rawValue == s }
    }
    
    func encode() -> String {
        return "O_\(Self.allCases.firstIndex(of: self)!)"
    }
}
