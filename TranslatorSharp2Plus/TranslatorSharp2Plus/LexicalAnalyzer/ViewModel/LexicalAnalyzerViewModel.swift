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
    
    @Published var identifierLexemas = [UserToken]()
    @Published var valueLexemas = [UserToken]()
    @Published var symbolLexemas = [UserToken]()
    
    private var analyzer = LexicalAnalyzer()
    
    func run() {
        analyzer.update(with: code)
        updateData()
    }
    
    func reset() {
        analyzer.update()
        updateData()
    }
    
    private func updateData() {
        code = analyzer.currentCode
        lexicalCode = analyzer.tokensRowValue
        identifierLexemas = analyzer.identifierTable.toSortedArray()
        valueLexemas = analyzer.valueTable.toSortedArray()
        symbolLexemas = analyzer.symbolTable.toSortedArray()
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
