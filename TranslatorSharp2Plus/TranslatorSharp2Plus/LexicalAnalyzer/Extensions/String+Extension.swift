//
//  String+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 06.03.2023.
//

import Foundation

extension String {
    var isKeyword: Bool {
        Keywords.isToken(self)
    }
    
    var isOperator: Bool {
        Operators.isToken(self)
    }
    
    func at(_ index: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: index)]
    }
}
