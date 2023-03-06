//
//  Character+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

extension Character {
    var isIdentifier: Bool {
        self.isLetter || self == "_"
    }
    
    var isStringIndicator: Bool {
        self == "\""
    }
    
    var isDivider: Bool {
        Dividers.isToken(self)
    }
    
    var isOperator: Bool {
        Operators.isToken(self)
    }
    
    var isSeparator: Bool {
        Separators.isToken(self)
    }
}
