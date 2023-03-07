//
//  PolishNotationViewModel.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 08.03.2023.
//

import Foundation

class PolishNotationViewModel: ObservableObject {
    
    @Published var code = ""
    @Published var polishNotationLexemas = ""
    @Published var polishNotation = ""
    
    private let lexicalAnalyzer = LexicalAnalyzer()
    private let polishConverter = PolishNotationConverter()
    
    func run() {
        lexicalAnalyzer.update(with: code, includeSeparators: true)
        let polishNotationTokens = polishConverter.convert(lexicalAnalyzer.lexemas)
        polishNotationLexemas = polishNotationTokens.stringRepresentation
        polishNotation = polishNotationTokens.valueRepresentation
    }
    
    func reset() {
        code.removeAll()
        run()
    }
}
