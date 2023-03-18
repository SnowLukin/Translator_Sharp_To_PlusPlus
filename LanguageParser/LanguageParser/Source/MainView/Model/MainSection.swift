//
//  MainSection.swift
//  LanguageParser
//
//  Created by Snow Lukin on 18.03.2023.
//

import Foundation

enum MainSection: String, CaseIterable, Identifiable {
    
    case codingSpace = "Coding space"
    case lexicalAnalyzer = "Lexical analyzer"
    case polishNotation = "Polish notation"
    
    var id: Self {
        return self
    }
    
    func next() -> Self {
        switch self {
        case .codingSpace:
            return .lexicalAnalyzer
        case .lexicalAnalyzer:
            return .polishNotation
        case .polishNotation:
            return .codingSpace
        }
    }
}
