//
//  LexemaType.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

enum LexemaType: Hashable {
    case identifier
    case keyword
    case constant
    case literal
    case `operator`
    case divider
    case separator
    case comment
    
    var prefix: String {
        switch self {
        case .identifier:
            return "I_"
        case .keyword:
            return "K_"
        case .constant:
            return "N_"
        case .literal:
            return "S_"
        case .operator:
            return "O_"
        case .divider:
            return "D_"
        case .separator:
            return ""
        default:
            return ""
        }
    }
}
