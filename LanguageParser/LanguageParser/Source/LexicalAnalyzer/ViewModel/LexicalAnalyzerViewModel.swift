//
//  LexicalAnalyzerViewModel.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

class LexicalAnalyzerViewModel: ObservableObject {
    @Published var code = String()
    @Published var lexicalCode = String()
    
    var identifierLexemas: [Lexema] {
        analyzer.identifierTable.data
    }
    
    var literalLexemas: [Lexema] {
        analyzer.literalTable.data
    }
    
    var constantLexemas: [Lexema] {
        analyzer.constantTable.data
    }
    
    private var analyzer = LexicalAnalyzer(includeSeparators: true)
    
    func run() {
        analyzer.convert(code)
        lexicalCode = analyzer.lexemas.map { $0.rawValue }.joined()
    }
    
    func reset() {
        analyzer.reset()
        code.removeAll()
        lexicalCode = analyzer.lexemas.map { $0.rawValue }.joined()
    }
}
