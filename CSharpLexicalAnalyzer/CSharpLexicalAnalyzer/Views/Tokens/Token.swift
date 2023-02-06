//
//  Token.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import Foundation

protocol Token: CaseIterable {
    static func isToken(_ s: String) -> Bool
    static func setToken(for s: String) -> Self?
    func encode() -> String
}

enum Tokens: String {
    case functionWord = "F"
    case identifiers = "I"
    case operations = "O"
    case dividers = "D"
    case numberConstants = "N"
    case stringConstants = "S"
}
