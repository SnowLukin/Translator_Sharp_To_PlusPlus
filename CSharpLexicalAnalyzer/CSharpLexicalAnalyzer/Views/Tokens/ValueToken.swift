//
// Created by Snow Lukin on 06.02.2023.
//

import Foundation

struct ValueToken {
    enum ValueType: String, CaseIterable {
        case int = "Ni"
        case float = "Nf"
        case double = "Nd"
        case string = "S"
    }
    
    let id: Int
    let type: ValueType
    let value: String
    
    func encode() -> String {
        "\(type.rawValue)_\(id)"
    }
}
