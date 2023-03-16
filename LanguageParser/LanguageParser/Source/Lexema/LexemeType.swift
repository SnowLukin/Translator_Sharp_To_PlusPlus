//
//  LexemeType.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

enum LexemeType: String, Hashable {
    case identifier = "I"
    case keyword = "K"
    case constant = "C"
    case literal = "L"
    case `operator` = "O"
    case divider = "D"
    case separator = "S"
    case comment = ""
    
    case arrayAddressCounter = "AAC"
    case functionCall = "FC"
    case conditional = "Condition"
    case goto = "Goto"
    case mark = "M"
    case declaration = "DC"
}
