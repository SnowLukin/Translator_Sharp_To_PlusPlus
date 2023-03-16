//
//  LexicalAnalyzer.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

enum UserTable {
    case identifier
    case literal
    case constant
}

final class LexicalAnalyzer {
    
    private(set) var lexemas: [Lexeme] = []
    private let identifierTable = UniqueLexemaTable()
    private let literalTable = UniqueLexemaTable()
    private let constantTable = UniqueLexemaTable()
    
    private var includeSeparators: Bool
    
    init(includeSeparators: Bool = false) {
        self.includeSeparators = includeSeparators
    }
    
    func convert(_ code: String) {
        var code = code
        reset()
        
        while !code.isEmpty {
            var status = false
            
            for (lexemaType, pattern) in states {
                if let matchRange = code.range(of: pattern, options: .regularExpression) {
                    updateTables(with: String(code[matchRange]), for: lexemaType)
                    code = String(code[matchRange.upperBound...])
                    status.toggle()
                    break
                }
            }
            
            if !status { fatalError("Unexpected symbol.") }
        }
    }
    
    func reset() {
        lexemas.removeAll()
        identifierTable.removeAll()
        literalTable.removeAll()
        constantTable.removeAll()
    }
    
    func getUserTable(for type: UserTable) -> [Lexeme] {
        switch type {
        case .identifier:
            return identifierTable.data
        case .constant:
            return constantTable.data
        case .literal:
            return literalTable.data
        }
    }
}

extension LexicalAnalyzer {
    typealias State = (type: LexemeType, pattern: String)
    
    private var states: [State] {
        [
            (.separator, LexicalPattern.separator.rawValue),
            (.comment, LexicalPattern.comment.rawValue),
            (.identifier, LexicalPattern.identifier.rawValue),
            (.constant, LexicalPattern.constant.rawValue),
            (.literal, LexicalPattern.literal.rawValue),
            (.operator, LexicalPattern.operator.rawValue),
            (.divider, LexicalPattern.divider.rawValue),
        ]
    }
    
    private func updateTables(with value: String, for type: LexemeType) {
        var lexema: Lexeme?
        
        switch type {
        case .identifier where SystemTable.keyword.getId(for: value) != nil:
            lexema = Lexeme(id: SystemTable.keyword.getId(for: value)!, value: value, type: .keyword)
        case .identifier:
            identifierTable.update(with: value, for: type)
            lexema = identifierTable.getLexema(for: value)
        case .constant:
            constantTable.update(with: value, for: type)
            lexema = constantTable.getLexema(for: value)
        case .literal:
            literalTable.update(with: value, for: type)
            lexema = literalTable.getLexema(for: value)
        case .operator:
            lexema = Lexeme(id: SystemTable.operator.getId(for: value)!, value: value, type: type)
        case .divider:
            lexema = Lexeme(id: SystemTable.divider.getId(for: value)!, value: value, type: type)
        case .separator where includeSeparators:
            lexema = Lexeme(id: SystemTable.separator.getId(for: value)!, value: value, type: type)
        default:
            return
        }
        lexemas.append(lexema!)
    }
}
