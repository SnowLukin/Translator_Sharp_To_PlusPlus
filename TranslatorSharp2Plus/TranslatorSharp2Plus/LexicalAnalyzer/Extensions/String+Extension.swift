//
//  String+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 06.03.2023.
//

import Foundation

extension String {
    
    var asKeyword: Token? {
        keywords.asToken(self, .keyword)
    }
    
    var asOperator: Token? {
        operators.asToken(self, .operator)
    }
    
    func at(_ index: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: index)]
    }
}
