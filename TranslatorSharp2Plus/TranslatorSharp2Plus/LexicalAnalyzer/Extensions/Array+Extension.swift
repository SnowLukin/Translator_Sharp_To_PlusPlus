//
//  Array+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import Foundation

extension Array where Element == Token {
    func find(for str: String) -> Token? {
        self.first(where: { $0.value == str })
    }
    
    mutating func safeAdd(_ str: String, _ type: TokenType) -> Token {
        guard let token = self.find(for: str) else {
            let token = Token(self.count, str, type)
            self.append(token)
            return token
        }
        return token
    }
}
