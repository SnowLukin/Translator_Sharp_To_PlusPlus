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
    
    var identifierLexemas: [Token] {
        analyzer.identifiers
    }
    var numericLexemas: [Token] {
        analyzer.numerics
    }
    
    var stringLiteralLexemas: [Token] {
        analyzer.stringLiterals
    }
    
    private var analyzer = LexicalAnalyzer()
    
    func run() {
        print(code)
        analyzer.update(with: code, includeSeparators: true)
        updateData()
    }
    
    func reset() {
        analyzer.update()
        updateData()
    }
    
    private func updateData() {
        code = analyzer.currentCode
        lexicalCode = analyzer.tokensRowValue
    }
}


//int a = 10;
//float b = 10.1;
//string c = "something";
//
//int functionName(int number) {
//    while (number < 20) {
//        number++;
//    }
//    return number;
//}
//
//if functionName(a) == 20 {
//    c = "abs";
//}
//b--;
