//
//  UserToken.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 06.03.2023.
//

import Foundation

struct UserToken: Hashable, Comparable {
    
    var id: Int
    var value: String
    
    static func < (lhs: UserToken, rhs: UserToken) -> Bool {
        lhs.id < rhs.id
    }
}
