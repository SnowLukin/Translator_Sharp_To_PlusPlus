//
//  IdentifierToken.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 06.02.2023.
//

import Foundation

struct IdentifierToken {
    let id: Int
    let value: String
    
    func encode() -> String {
        "I_\(id)"
    }
}
