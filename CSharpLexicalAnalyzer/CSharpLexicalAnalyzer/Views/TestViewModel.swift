//
//  TestViewModel.swift
//  CSharpLexicalAnalyzer
//
//  Created by Snow Lukin on 05.02.2023.
//

import SwiftUI


final class TestViewModel: ObservableObject {
    @Published var outputCodes: [String] = []
    var identifiersTable: [IdentifierToken] = []
    var valuesTable: [ValueToken] = []
    
    let sampleCode = """
    double c = 3;
    int b;
    int a = 1;
    int e3 = 2;
    int chh = 0;
    if (c > 2.79) {
        b = a * e3;
        f = "as ;ds";
        chh += 1;
    }
    int count = 0;
    while(int i = 0; i <= n; i++) {
        count++;
    }
    """
    
    func scan(_ input: String) {
        outputCodes = []
        var buffer = "" // buffer collects the characters and resets when we find a Token
        var isInQuotes = false  // flag to check if we are inside the string

        for char in input {
            /// Current char is a divider
            if let dividerToken = DividerTokens.setToken(for: (String(char))) {
                /// If the current char is a <<">>
                if dividerToken == .quotes {
                    handleQuotes(&isInQuotes, &buffer)
                } else if isInQuotes {
                    /// Even if current char is a divider is we are inside the string we just add the char to the buffer
                    buffer += String(char)
                    continue
                }
                /// If word before the divider was a token adding it to the output
                /// otherwise if there was a word before the divider it is a variable name or a value
                handleNonDividerTokens(dividerToken: dividerToken, &buffer)
                /// Adding a divider to the output and reset the buffer.
                /// In lexical analyzer we skip whitespaces and new lines.
                if dividerToken != .whitespace && dividerToken != .endl {
                    outputCodes.append(dividerToken.encode())
                }
                buffer = ""
            } else {    // if current char is not a divider, add current char to buffer and go to the next char
                buffer += String(char)
            }
        }
    }
    
    private func handleQuotes(_ isInQuotes: inout Bool, _ buffer: inout String) {
        if isInQuotes {
            /// If we are already had one before then we know current char is the one that ends the string
            let valueToken = ValueToken(id: valuesTable.count, type: .string, value: buffer)
            buffer = ""
            outputCodes.append(valueToken.encode())
        }
        /// If it starts the string then switch the flag to make it true
        /// If we had it set to true before and now met closing char then it will switch to false
        isInQuotes.toggle()
    }
    
    private func handleNonDividerTokens(dividerToken: DividerTokens, _ buffer: inout String) {
        // if current divider is "(" and before that we had while statement
        if let whileStatementToken = FunctionWordTokens.setToken(for: buffer),
            whileStatementToken == .whileStatement,
            dividerToken == .startRoundBracket {
            /// buffer == while
            /// divider == (
            outputCodes.append(whileStatementToken.encode())
        } else if let token = setToken(buffer) {   // token
            // First we check if we are having a double operation such as >=, ==, ++, *= etc.
            if let currentToken = token as? OperationTokens, buffer.isEmpty,
               let prevCode = outputCodes.last,
               let previousToken = OperationTokens.decode(prevCode),
               let newToken = OperationTokens.addTokens(previousToken, currentToken) {
                
                /// If we had an operation token before and now, and if we can combine em into double operation
                /// Remove previous single operation token and append new double operation token
                outputCodes.removeLast()
                outputCodes.append(newToken.encode())
            } else { // Otherwise we just add token to the output
                outputCodes.append(token.encode())
            }
        } else if !buffer.isEmpty {
            if buffer.isNumber() {  // number value
                let valueToken = ValueToken(id: valuesTable.count, type: .double, value: buffer)
                valuesTable.append(valueToken)
                outputCodes.append(valueToken.encode())
            } else {    // variable name
                let identToken = IdentifierToken(id: identifiersTable.count, value: buffer)
                identifiersTable.append(identToken)
                outputCodes.append(identToken.encode())
            }
        }
    }
    
    private func setToken(_ s: String) -> (any Token)? {
        if let opertationToken = OperationTokens.setToken(for: s) {return opertationToken}
        else if let functionWordToken = FunctionWordTokens.setToken(for: s) {return functionWordToken}
        else if let dividerToken = DividerTokens.setToken(for: s) {return dividerToken}
        return nil
    }
}
