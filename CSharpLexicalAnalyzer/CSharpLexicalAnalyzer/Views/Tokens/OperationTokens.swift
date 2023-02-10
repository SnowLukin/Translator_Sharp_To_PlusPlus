//
//  OperationTokens.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import SwiftUI

enum OperationTokens: String, Token {
    case plus = "+"             // 0
    case minus = "-"            // 1
    case multiplier = "*"       // 2
    case divider = "/"          // 3
    case remainder = "%"        // 4
    case equalTo = "="          // 5
    case exclamationMark = "!"   // 6
    
    case doublePlus = "++"      // 7
    case doubleMinus = "--"     // 8
    case plusEqualTo = "+="     // 9
    case minusEqualTo = "-="    // 10
    case divideEqualTo = "/="   // 11
    case multiplyEqualTo = "*=" // 12
    case remaindEqualTo = "%="  // 13
    
    case less = "<"             // 14
    case lessOrEqual = "<="     // 15
    case more = ">"             // 16
    case moreOrEqual = ">="     // 17
    case isEqual = "=="         // 18
    case notEqual = "!="        // 19
    
    
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
