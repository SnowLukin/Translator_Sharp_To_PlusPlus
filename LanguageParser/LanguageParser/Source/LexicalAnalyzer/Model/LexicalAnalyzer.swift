//
//  LexicalAnalyzer.swift
//  LanguageParser
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

final class LexicalAnalyzer {
    
    private(set) var lexemas: [Lexema] = []
    let identifierTable = UniqueLexemaTable()
    let literalTable = UniqueLexemaTable()
    let constantTable = UniqueLexemaTable()
    
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
        print(lexemas)
    }
    
    func reset() {
        lexemas.removeAll()
        identifierTable.removeAll()
        literalTable.removeAll()
        constantTable.removeAll()
    }
}

extension LexicalAnalyzer: SystemTables {
    typealias State = (type: LexemaType, pattern: String)
    
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
    
    private func updateTables(with value: String, for type: LexemaType) {
        switch type {
        case .identifier where keywords[value] != nil:
            let lexema = Lexema(id: keywords[value]!, value: value, type: .keyword)
            lexemas.append(lexema)
        case .identifier:
            identifierTable.update(with: value, for: type)
            lexemas.append(identifierTable.data.last!)
        case .constant:
            constantTable.update(with: value, for: type)
            lexemas.append(constantTable.data.last!)
        case .literal:
            literalTable.update(with: value, for: type)
            lexemas.append(literalTable.data.last!)
        case .operator:
            let lexema = Lexema(id: operators[value]!, value: value, type: type)
            lexemas.append(lexema)
        case .divider:
            let lexema = Lexema(id: dividers[value]!, value: value, type: type)
            lexemas.append(lexema)
        case .separator where includeSeparators:
            let lexema = Lexema(id: separators[value]!, value: value, type: type)
            lexemas.append(lexema)
        default:
            break
        }
    }
}
