//
//  LexicalToken.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

enum LexicalToken: Hashable {
    case identifier(UserToken)
    case keyword(String)
    case integerLiteral(UserToken)
    case floatLiteral(UserToken)
    case stringLiteral(UserToken)
    case `operator`(String)
    case divider(String)
    case separator(String)
    
    var stringRepresentation: String {
        switch self {
        case .identifier(let token):
            return "I_" + String(token.id)
        case .keyword(let string):
            return "K_" + (Keywords.getToken(for: string)?.encode() ?? "Error")
        case .integerLiteral(let token), .floatLiteral(let token):
            return "N_" + String(token.id)
        case .stringLiteral(let token):
            return "S_" + String(token.id)
        case .operator(let string):
            return "O_" + (Operators.getToken(for: string)?.encode() ?? "Error")
        case .divider(let string):
            return "D_" + (Dividers.getToken(for: string)?.encode() ?? "Error")
        case .separator(let string):
            return string
        }
    }
}
