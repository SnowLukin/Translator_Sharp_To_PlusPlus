//
//  SystemTables.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import Foundation

protocol SystemTables {}

extension SystemTables {
    
    var dividers: [String:Int] {
        let symbols = ["{", "}", "(", ")", ",", ";", "\\", "[", "]"]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
    
    var operators: [String:Int] {
        let symbols = ["+", "-", "*", "/", "%", "=", ">", "<", "!", "&", "|", "&&", "||", "++", "--", "+=", "-=", "/=", "*=", "%=", "<=", ">=", "==", "!="]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
    
    var keywords: [String:Int] {
        let symbols = ["class", "if", "else", "while", "int", "float", "double", "string", "namespace", "void", "static", "using", "System", "break", "return", "new"]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
    
    var separators: [String:Int] {
        let symbols = [" ", "\n", "\t"]
        return Dictionary(uniqueKeysWithValues: zip(symbols, 1...symbols.count))
    }
}
