//
//  UniqueLexemaTable.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

class UniqueLexemaTable {
    private var hashmap: [String:Lexema] = [:]
    private(set) var data: [Lexema] = []
    
    func update(with value: String, for type: LexemaType) {
        if hashmap[value] == nil {
            let lexema = Lexema(id: hashmap.count, value: value, type: type)
            hashmap[value] = lexema
            data.append(lexema)
        }
    }
    
    func removeAll() {
        hashmap.removeAll()
        data.removeAll()
    }
}
