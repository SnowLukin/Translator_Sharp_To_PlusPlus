//
//  MultiCharOperators.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

enum MultiCharOperators: String, CaseIterable, Lexema {
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
