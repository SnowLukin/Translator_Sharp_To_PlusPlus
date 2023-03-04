//
//  Lexema.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import Foundation

protocol Lexema: RawRepresentable, CaseIterable, Hashable {
    static func getToken(for s: String) -> Self?
    func encode(with padding: Int) -> String
}

extension Lexema {
    static func getToken(for s: String) -> Self? {
        Self.allCases.first { $0.rawValue as? String == s }
    }
    
    static func isToken<T>(_ value: T) -> Bool where T: Equatable, T: LosslessStringConvertible {
        let rawValue = String(value)
        return Self.allCases.contains { $0.rawValue as? String == rawValue }
    }
    
    func encode(with padding: Int = 0) -> String {
        "\((Self.allCases.firstIndex(of: self) as? Int ?? 0) + padding)"
    }
}
