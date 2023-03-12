//
//  PolishNotationViewModel.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

class PolishNotationViewModel: ObservableObject {
    @Published var code = ""
    @Published var polishNotation = ""
    
    private let analyzer = LexicalAnalyzer()
    private let polishNotationConvertor = PolishNotationConverter()
    
    func run() {
        analyzer.convert(code)
        polishNotationConvertor.update(analyzer.lexemas)
        polishNotation = polishNotationConvertor.output.valueRepresentation
    }
    
    func reset() {
        analyzer.reset()
        code.removeAll()
        polishNotation.removeAll()
    }
}
