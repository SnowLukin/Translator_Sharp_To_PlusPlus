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
    case exclamationMark = "!"
    
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
    
    static func decode(_ s: String) -> OperationTokens? {
        Self.allCases.first { $0.encode() == s }
    }
    
    func encode() -> String {
        return "O_\(Self.allCases.firstIndex(of: self)!)"
    }
    
    static func addTokens(_ t1: Self, _ t2: Self) -> Self? {
        if t1 == .plus && t2 == .equalTo {return .plusEqualTo}
        else if t1 == .minus && t2 == .equalTo {return .minusEqualTo}
        else if t1 == .multiplier && t2 == .equalTo {return .multiplyEqualTo}
        else if t1 == .divider && t2 == .equalTo {return .divideEqualTo}
        else if t1 == .remainder && t2 == .equalTo {return .remaindEqualTo}
        else if t1 == .more && t2 == .equalTo {return .moreOrEqual}
        else if t1 == .less && t2 == .equalTo {return .lessOrEqual}
        else if t1 == .equalTo && t2 == .equalTo {return .isEqual}
        else if t1 == .exclamationMark && t2 == .equalTo {return .notEqual}
        else if t1 == .plus && t2 == .plus {return .doublePlus}
        else if t1 == .minus && t2 == .minus {return .doubleMinus}
        return nil
    }
}
