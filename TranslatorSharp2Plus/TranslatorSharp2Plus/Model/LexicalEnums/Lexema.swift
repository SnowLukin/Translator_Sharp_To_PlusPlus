//
//  Lexema.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

protocol Lexema: RawRepresentable, CaseIterable, Hashable {
    func encode() -> String
}

extension Lexema {
    static func getToken<T>(for value: T) -> Self? where T: Equatable, T: LosslessStringConvertible {
        let rawValue = String(value)
        return Self.allCases.first { $0.rawValue as? String == rawValue }
    }
    
    static func isToken<T>(_ value: T) -> Bool where T: Equatable, T: LosslessStringConvertible {
        let rawValue = String(value)
        return Self.allCases.contains { $0.rawValue as? String == rawValue }
    }
    
    func encode() -> String {
        "\(Self.allCases.firstIndex(of: self)!)"
    }
}
