//
//  LexicalAnalyzerViewModel.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

class LexicalAnalyzerViewModel: ObservableObject {
    
    @Published var lexemesCode = String()
    
    private var analyzer = LexicalAnalyzer(includeSeparators: true)
    
    var identifierLexemas: [Lexeme] {
        analyzer.getUserTable(for: .identifier)
    }
    
    var literalLexemas: [Lexeme] {
        analyzer.getUserTable(for: .literal)
    }
    
    var constantLexemas: [Lexeme] {
        analyzer.getUserTable(for: .constant)
    }
    
    var lexemas: [Lexeme] {
        analyzer.lexemas
    }
    
    func update(with code: String) {
        analyzer.convert(code)
        lexemesCode = analyzer.lexemas.map { $0.rawValue }.joined()
    }
}
