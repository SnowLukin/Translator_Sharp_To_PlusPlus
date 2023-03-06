//
//  LexicalAnalyzerViewModel.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 06.03.2023.
//

import SwiftUI

class LexicalAnalyzerViewModel: ObservableObject {
    
    @Published var code = String()
    @Published var lexicalCode = String()
    
    private var analyzer = LexicalAnalyzer()
    
    func run() {
        analyzer.code = code
        lexicalCode = analyzer.tokensRowValue
    }
    
    func reset() {
        code.removeAll()
        lexicalCode.removeAll()
    }
    
}
