//
//  Extension+String.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 06.02.2023.
//

import Foundation

extension String {
    func isNumber() -> Bool {
        Int(self) != nil || Double(self) != nil
    }
}
