//
//  TokenTables.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import Foundation

let numbers: Regex<Substring> = /[0-9]/
let symbols: Regex<Substring> = /[a-zA-Z_]/

let dividers: [Character:Int] = [
    "{": 0,
    "}": 1,
    "(": 2,
    ")": 3,
    ",": 4,
    ";": 5,
    "\"": 6,
    "[": 7,
    "]": 8
]

let operators: [String:Int] = [
    "+" : 0,
    "-" : 1,
    "*" : 2,
    "%" : 3,
    "=" : 4,
    ">" : 5,
    "<" : 6,
    "!" : 7,
    "&" : 8,
    "|" : 9,
    "&&" : 10,
    "||" : 11,
    "++" : 12,
    "--" : 13,
    "+=" : 14,
    "-=" : 15,
    "/=" : 16,
    "*=" : 17,
    "%=" : 18,
    "<=" : 19,
    ">=" : 20,
    "==" : 21,
    "!=": 22
]

let separators: [Character:Int] = [
    " ": 0,
    "\n": 1,
    "\t": 2
]

let keywords: [String:Int] = [
    "class" : 0,
    "if" : 1,
    "else" : 2,
    "while" : 3,
    "int" : 4,
    "float" : 5,
    "double" : 6,
    "string" : 7,
    "namespace" : 8,
    "void" : 9,
    "static" : 10,
    "using" : 11,
    "System" : 12,
    "break" : 13,
    "return" : 14,
    "new": 15
]
