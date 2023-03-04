//
//  LexicalToken.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

enum LexicalToken {
    case Identifier(String)
    case Keyword(String)
    case IntegerLiteral(String)
    case FloatLiteral(String)
    case StringLiteral(String)
    case Operator(String)
    case Divider(String)
    
    func getStringRepresentation() -> String {
        switch self {
        case .Identifier(let string):
            return "I_" + string
        case .Keyword(let string):
            return "K_" + (Keywords.getToken(for: string)?.encode() ?? "Error")
        case .IntegerLiteral(let string):
            return "Ni_" + string
        case .FloatLiteral(let string):
            return "Nf_" + string
        case .StringLiteral(let string):
            return "S_" + string
        case .Operator(let string):
            return "O_" + (Operators.getToken(for: string)?.encode() ?? "Error")
        case .Divider(let string):
            return "D_" + (Dividers.getToken(for: string)?.encode() ?? "Error")
        }
    }
}
