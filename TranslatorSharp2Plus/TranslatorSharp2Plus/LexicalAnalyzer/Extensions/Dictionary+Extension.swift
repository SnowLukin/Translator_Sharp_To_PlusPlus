//
//  Dictionary+Extension.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 06.03.2023.
//

import Foundation


extension Dictionary where Key == String, Value == UserToken {
    func toSortedArray() -> [UserToken] {
        self.map { $0.value }.sorted(by: <)
    }
    
    mutating func safeAdd(_ key: String) -> UserToken {
        guard let token = self[key] else {
            let newToken = UserToken(id: self.count, value: key)
            self[key] = newToken
            return newToken
        }
        return token
    }
}
