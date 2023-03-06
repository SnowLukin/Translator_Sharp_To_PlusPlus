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
        Self.allCases.first { $0.rawValue as? String == String(value) }
    }
    
    static func isToken<T>(_ value: T) -> Bool where T: Equatable, T: LosslessStringConvertible {
        Self.allCases.contains { $0.rawValue as? String == String(value) }
    }
    
    func encode() -> String {
        "\(Self.allCases.firstIndex(of: self)!)"
    }
}
