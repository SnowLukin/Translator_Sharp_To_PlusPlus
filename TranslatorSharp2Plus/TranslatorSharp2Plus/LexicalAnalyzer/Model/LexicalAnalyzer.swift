//
//  LexicalAnalyzer.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//


import Foundation


class LexicalAnalyzer {
    
    var identifierTable: [String:UserToken] = [:]   // Names of variable, classes or functions
    var valueTable: [String:UserToken] = [:]    // Numbers
    var symbolTable: [String:UserToken] = [:]   // String values
    
    var code: String {
        didSet {
            identifierTable.removeAll()
            valueTable.removeAll()
            symbolTable.removeAll()
        }
    }
    
    private var buffer = ""
    private var startingIndex = 0
    
    var tokens: [LexicalToken] {
        var tokens = [LexicalToken]()
        startingIndex = 0
        
        while startingIndex < code.count {
            let token = startState()
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
    
    func reset() {
        code.removeAll()
        identifierTable.removeAll()
        valueTable.removeAll()
        symbolTable.removeAll()
    }
}


// MARK: - States
extension LexicalAnalyzer {
    private func startState() -> LexicalToken {
        let char = code.at(startingIndex)
        startingIndex += 1
        
        if char.isIdentifier { return identifierState(String(char)) }
        if char.isSeparator { return .separator(String(char)) }
        if char.isNumber { return integerState(String(char)) }
        if char.isStringIndicator { return stringLiteralState(String(char)) }
        if char.isDivider { return .divider(String(char)) }
        if char.isOperator { return operationState(String(char)) }
        
        fatalError("Met unexpected character: \(char).")
    }
    
    private func identifierState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        if char.isIdentifier {
            startingIndex += 1
            return identifierState(buffer + String(char))
        }
        if buffer.isKeyword {  return .keyword(buffer) }
        
        return .identifier(identifierTable.safeAdd(buffer))
    }
    
    
    
    private func integerState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        switch char {
        case ".", "e", "E":
            startingIndex += 1
            return floatState(buffer + String(char))
        case _ where char.isNumber:
            startingIndex += 1
            return integerState(buffer + String(char))
        default:
            return .integerLiteral(valueTable.safeAdd(buffer))
        }
    }
    
    private func floatState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        if char.isNumber {
            startingIndex += 1
            return floatState(buffer + String(char))
        } else {
            return .floatLiteral(valueTable.safeAdd(buffer))
        }
    }
    
    private func stringLiteralState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        startingIndex += 1
        let buffer = buffer + String(char)
        
        return char.isStringIndicator ? .stringLiteral(symbolTable.safeAdd(buffer)) : stringLiteralState(buffer)
    }
    
    private func operationState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        let possibleOperation = buffer + String(char)
        if possibleOperation.isOperator {
            startingIndex += 1
            return operationState(possibleOperation)
        }
        return .operator(buffer)
    }
}
