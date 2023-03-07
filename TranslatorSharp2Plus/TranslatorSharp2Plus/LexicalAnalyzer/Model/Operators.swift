//
//  Operators.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

enum Operators: String, Lexema {
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case remainder = "%"
    case equal = "="
    case more = ">"
    case less = "<"
    case exclamationMark = "!"
    case singleAnd = "&"
    case singleOr = "|"
    
    case doubleAnd = "&&"
    case doubleOr = "||"
    case doublePlus = "++"
    case doubleMinus = "--"
    case plusEqualTo = "+="
    case minusEqualTo = "-="
    case divideEqualTo = "/="
    case multiplyEqualTo = "*="
    case remaindEqualTo = "%="
    case lessOrEqual = "<="
    case moreOrEqual = ">="
    case isEqual = "=="
    case notEqual = "!="
}
