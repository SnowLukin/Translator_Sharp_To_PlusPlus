//
//  Dividers.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

enum Dividers: String, CaseIterable, Lexema {
    case startBracket = "{"          // 0
    case endBracket = "}"            // 1
    case startRoundBracket = "("     // 2
    case endRoundBracket = ")"       // 3
    case endl = "\n"                // 4
    case comma = ","                // 5
    case semicolon = ";"            // 6
    case quotes = "\""              // 7
    case dot = "."                  // 8
}
