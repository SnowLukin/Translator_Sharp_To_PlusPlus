//
//  Lexema.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

struct Lexema: Hashable {
    let id: Int
    let value: String
    let type: LexemaType
    
    var rawValue: String {
        switch type {
        case .separator:
            return value == " " ? "" : value
        default:
            return type.prefix + String(id) + " "
        }
    }
    
    var precedence: Int {
        switch value {
        case "*", "/":
            return 2
        case "+", "-":
            return 1
        default:
            return 0
        }
    }
}
