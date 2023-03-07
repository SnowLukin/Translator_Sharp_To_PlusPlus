//
//  TokenType.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

enum TokenType: Hashable {
    case identifier
    case keyword
    case numericLiteral
    case stringLiteral
    case `operator`
    case divider
    case separator
    
    var prefix: String {
        switch self {
        case .identifier:
            return "I_"
        case .keyword:
            return "K_"
        case .numericLiteral:
            return "N_"
        case .stringLiteral:
            return "S_"
        case .operator:
            return "O_"
        case .divider:
            return "D_"
        case .separator:
            return ""
        }
    }
}
