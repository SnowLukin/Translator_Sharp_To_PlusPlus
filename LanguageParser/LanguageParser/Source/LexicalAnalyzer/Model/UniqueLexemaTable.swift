//
//  UniqueLexemaTable.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

class UniqueLexemaTable {
    private var hashmap: [String:Lexeme] = [:]
    private(set) var data: [Lexeme] = []
    
    func update(with value: String, for type: LexemeType) {
        if hashmap[value] == nil {
            let lexema = Lexeme(id: hashmap.count, value: value, type: type)
            hashmap[value] = lexema
            data.append(lexema)
        }
    }
    
    func getLexema(for value: String) -> Lexeme? {
        hashmap[value]
    }
    
    func removeAll() {
        hashmap.removeAll()
        data.removeAll()
    }
}
