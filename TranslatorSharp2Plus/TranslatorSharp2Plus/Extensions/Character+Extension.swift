//
//  Character+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

extension Character {
    func isStartOfStringLiteral() -> Bool {
        self == "“" || self == "\""
    }
    
    func isEndOfStringLiteral() -> Bool {
        self == "”" || self == "\""
    }
    
    func isIdentifier() -> Bool {
        self.isLetter || self == "_"
    }
}
