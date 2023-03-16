//
//  Sequence+Lexema.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import Foundation

extension Sequence where Element == Lexeme {
    var stringRepresentation: String {
        self.map { $0.rawValue }.joined()
    }
    
    var valueRepresentation: String {
        self.map { $0.value }.joined(separator: " ")
    }
}
