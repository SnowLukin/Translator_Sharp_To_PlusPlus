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
        case bool = "B"
    }
    
    let id: Int
    let type: ValueType
    let value: String
    
    static func getID(_ s: String) -> Int? {
        Int(s.filter { $0.isNumber }) ?? nil
    }
    
    func encode() -> String {
        "\(type.rawValue)_\(id)"
    }
}
