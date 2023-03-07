//
//  Dictionary+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 06.03.2023.
//

import Foundation


extension Dictionary where Key == String, Value == Int {
    func asToken(_ str: String, _ type: TokenType) -> Token? {
        self[str] != nil ? Token(self[str]!, str, type) : nil
    }
}

extension Dictionary where Key == Character, Value == Int {
    func asToken(_ char: Character, _ type: TokenType) -> Token? {
        self[char] != nil ? Token(self[char]!, char, type) : nil
    }
}
