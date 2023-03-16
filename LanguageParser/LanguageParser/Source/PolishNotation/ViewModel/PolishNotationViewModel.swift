//
//  PolishNotationViewModel.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

class PolishNotationViewModel: ObservableObject {
    @Published var polishNotation = ""
    
    private let analyzer = LexicalAnalyzer()
    private let polishNotationConvertor = PolishNotationConverter()
    
    func update(with code: String) {
        analyzer.convert(code)
        polishNotationConvertor.update(analyzer.lexemas)
        polishNotation = polishNotationConvertor.output.valueRepresentation
    }
}
