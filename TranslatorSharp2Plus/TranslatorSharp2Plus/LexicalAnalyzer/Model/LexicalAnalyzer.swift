//
//  LexicalAnalyzer.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//


import Foundation

class LexicalAnalyzer {
    
    var code: String
    
    var identifierTable: [String:UserToken] = [:]   // Names of variable, classes or functions
    var valueTable: [String:UserToken] = [:]    // Numbers
    var symbolTable: [String:UserToken] = [:]   // String values
    
    private var buffer = ""
    private var startingIndex = 0
    
    var tokens: [LexicalToken] {
        var tokens = [LexicalToken]()
        startingIndex = 0
        
        while startingIndex < code.count {
            let token = performStartState()
            // print(token)
            tokens.append(token)
        }
        return tokens
    }
    
    var tokensRowValue: String {
        var displayString = ""
        for token in tokens {
            switch token {
            case .separator(let value):
                displayString += value == " " ? "" : token.stringRepresentation
            default:
                displayString += token.stringRepresentation + " "
            }
        }
        return displayString
    }
    
    init(_ code: String = "") {
        self.code = code
    }
}


// MARK: - States
extension LexicalAnalyzer {
    private func performStartState() -> LexicalToken {
        let char = code[code.index(code.startIndex, offsetBy: startingIndex)]
        startingIndex += 1
        
        switch char {
        case _ where char.isIdentifier:   // Identifiers
            return performIdentifierState(String(char))
        case _ where Separators.isToken(char):  // Whitespaces, newlines, tabs
            return .separator(String(char))
        case _ where char.isNumber: // Integers, Floats
            return performIntegerState(String(char))
        case _ where char.isStringIndicator:     // Start of the string -> "
            return performStringLiteralState(String(char))
        case _ where Dividers.isToken(char):    // Dividers: ,.; etc.
            return .divider(String(char))
        case _ where Operators.isToken(char):   // Operators: +-= etc.
            return performOperationState(String(char))
        default:
            fatalError("Met unexpected character: \(char).")
        }
    }
    
    private func performIdentifierState(_ buffer: String = "") -> LexicalToken {
        let char = code[code.index(code.startIndex, offsetBy: startingIndex)]
        
        if char.isIdentifier {
            startingIndex += 1
            return performIdentifierState(buffer + String(char))
        }
        if Keywords.isToken(buffer) {  return .keyword(buffer) }
        
        if let existedToken = identifierTable[buffer] { return .identifier(existedToken) }
        let newToken = UserToken(id: identifierTable.count, value: buffer)
        identifierTable[buffer] = newToken
        return .identifier(newToken)
    }
    
    private func performIntegerState(_ buffer: String = "") -> LexicalToken {
        let char = code[code.index(code.startIndex, offsetBy: startingIndex)]
        
        switch char {
        case ".":
            startingIndex += 1
            return performFloatState(buffer + String(char))
        case _ where char.isNumber:
            startingIndex += 1
            return performIntegerState(buffer + String(char))
        default:
            if let existedToken = valueTable[buffer] { return .integerLiteral(existedToken) }
            let newToken = UserToken(id: valueTable.count, value: buffer)
            valueTable[buffer] = newToken
            return .integerLiteral(newToken)
        }
    }
    
    private func performFloatState(_ buffer: String = "") -> LexicalToken {
        let char = code[code.index(code.startIndex, offsetBy: startingIndex)]
        
        if char.isNumber {
            startingIndex += 1
            return performFloatState(buffer + String(char))
        } else {
            if let existedToken = valueTable[buffer] { return .floatLiteral(existedToken) }
            let newToken = UserToken(id: valueTable.count, value: buffer)
            valueTable[buffer] = newToken
            return .floatLiteral(newToken)
        }
    }
    
    private func performStringLiteralState(_ buffer: String = "") -> LexicalToken {
        let char = code[code.index(code.startIndex, offsetBy: startingIndex)]
        
        startingIndex += 1
        if !char.isStringIndicator {
            return performStringLiteralState(buffer + String(char))
        }
        let buffer = buffer + String(char)  // Adding the closing " symbol
        if let existedToken = symbolTable[buffer] { return .stringLiteral(existedToken) }
        let newToken = UserToken(id: symbolTable.count, value: buffer)
        symbolTable[buffer] = newToken
        return .stringLiteral(newToken)
    }
    
    private func performOperationState(_ buffer: String = "") -> LexicalToken {
        let char = code[code.index(code.startIndex, offsetBy: startingIndex)]
        
        let possibleOperation = buffer + String(char)
        if Operators.isToken(possibleOperation) {
            startingIndex += 1
            return performOperationState(possibleOperation)
        }
        return .operator(buffer)
    }
}
