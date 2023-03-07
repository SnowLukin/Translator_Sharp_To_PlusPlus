//
//  Character+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

extension Character {
    
    var isStringIndicator: Bool {
        self == "\""
    }
    
    var asDivider: Token? {
        dividers.asToken(self, .divider)
    }
    
    var asOperator: Token? {
        operators.asToken(String(self), .operator)
    }
    
    var asSeparator: Token? {
        separators.asToken(self, .separator)
    }
}
