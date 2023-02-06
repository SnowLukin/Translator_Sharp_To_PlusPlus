//
//  TestViewModel.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import SwiftUI


class TestViewModel: ObservableObject {
    let sampleCode = """
    if (c > 2.79) {
        b = a * e3;
        f = "as ;ds";
    }
    """
    
    var identifiersTable: [IdentifierToken] = []
    var valuesTable: [ValueToken] = []
    
    func scan(_ input: String) -> String {
        var output = "" // contains the codes of the tokens
        var buffer = "" // buffer collects the characters and resets when we find a Token
        
        var isInQuotes = false  // flag to check if we are inside the string

        for char in input {
            /// Current char is a divider
            if let dividerToken = DividerTokens.setToken(for: (String(char))) {
                /// If the current char is a <<">>
                if dividerToken == .quotes {
                    if isInQuotes {
                        /// If we are already had one before then we know current char is the one that ends the string
                        let valueToken = ValueToken(id: valuesTable.count, type: .string, value: buffer)
                        buffer = ""
                        output += valueToken.encode() + " "
                    }
                    /// If it starts the string then switch the flag to make it true
                    /// If we had it set to true before and now met closing char then it will switch to false
                    isInQuotes.toggle()
                } else if isInQuotes {
                    /// Even if current char is a divider is we are inside the string we just add the char to the buffer
                    buffer += String(char)
                    continue
                }
                /// If word before the divider was a token adding it to the output
                /// otherwise if there was a word before the divider it is a variable name or a value
                if let token = setToken(buffer) {
                    output += token.encode() + " "
                } else if !buffer.isEmpty {
                    if buffer.isNumber() {  // number value
                        let valueToken = ValueToken(id: valuesTable.count, type: .double, value: buffer)
                        valuesTable.append(valueToken)
                        output += valueToken.encode() + " "
                    } else {    // variable name
                        let identToken = IdentifierToken(id: identifiersTable.count, value: buffer)
                        identifiersTable.append(identToken)
                        output += identToken.encode() + " "
                    }
                }
                /// Adding a divider to the output and reset the buffer.
                /// In lexical analyzer we skip whitespaces and new lines.
                output += dividerToken == .whitespace || dividerToken == .endl ? "" : dividerToken.encode() + " "
                buffer = ""
            } else {    // if current char is not a divider, add current char to buffer and go to the next char
                buffer += String(char)
            }
        }
        return output
    }
    
    private func setToken(_ s: String) -> (any Token)? {
        if let opertationToken = OperationTokens.setToken(for: s) {return opertationToken}
        else if let functionWordToken = FunctionWordTokens.setToken(for: s) {return functionWordToken}
        else if let dividerToken = DividerTokens.setToken(for: s) {return dividerToken}
        return nil
    }
}

extension String {
    func isNumber() -> Bool {
        Int(self) != nil || Double(self) != nil
    }
}
