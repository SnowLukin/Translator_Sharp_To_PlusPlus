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
            guard let token = startState() else { continue }
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
    private func startState() -> LexicalToken? {
        let char = code.at(startingIndex)
        startingIndex += 1
        
        if char.isIdentifier { return identifierState(String(char)) }
        if char.isSeparator { return .separator(String(char)) }
        if char == "." { return floatState("0" + String(char)) }
        if char.isNumber { return intState(String(char)) }
        if char.isStringIndicator { return stringState(String(char)) }
        if char.isDivider { return .divider(String(char)) }
        if char.isOperator { return operationState(String(char)) }
        if char == "/", code.at(startingIndex) == "/" { return commentState() }
        if char == "/", code.at(startingIndex) == "*" { return multiCommentState() }
        
        fatalError("Met unexpected character: \(char).")
    }
    
    private func commentState() -> LexicalToken? {
        if startingIndex < code.count, code.at(startingIndex) != "\n" {
            startingIndex += 1
            return commentState()
        }
        return startingIndex < code.count ? startState() : nil
    }
    
    private func multiCommentState() -> LexicalToken? {
        startingIndex += 1
        let char = code.at(startingIndex)
        if startingIndex < code.count - 1, char == "*", code.at(startingIndex + 1) == "/" {
            startingIndex += 2
            return startingIndex < code.count ? startState() : nil
        }
        if startingIndex >= code.count - 1 { fatalError("Multiline comment doesnt close.") }
        return multiCommentState()
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
    
    private func intState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        switch char {
        case ".":
            startingIndex += 1
            return floatState(buffer + String(char))
        case _ where char.isNumber:
            startingIndex += 1
            return intState(buffer + String(char))
        default:
            if buffer.first == "." {
                return .floatLiteral(valueTable.safeAdd("0" + buffer))
            }
            return .integerLiteral(valueTable.safeAdd(buffer))
        }
    }
    
    private func floatState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        switch char {
        case "e", "E":
            startingIndex += 1
            return exponentState(buffer + String(char))
        case _ where char.isNumber:
            startingIndex += 1
            return floatState(buffer + String(char))
        default:
            return .floatLiteral(valueTable.safeAdd(buffer))
        }
    }

    private func exponentState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        switch char {
        case "+", "-":
            startingIndex += 1
            return signedExponentState(buffer + String(char))
        case _ where char.isNumber:
            startingIndex += 1
            return unsignedExponentState(buffer + String(char))
        default:
            fatalError("Met unexpected character in exponent: \(char).")
        }
    }

    private func signedExponentState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        if char.isNumber {
            startingIndex += 1
            return unsignedExponentState(buffer + String(char))
        }
        fatalError("Expected a digit in signed exponent: \(char).")
    }

    private func unsignedExponentState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        
        if char.isNumber {
                startingIndex += 1
            return unsignedExponentState(buffer + String(char))
        }
        return .floatLiteral(valueTable.safeAdd(buffer))
    }

    
    private func stringState(_ buffer: String = "") -> LexicalToken {
        let char = code.at(startingIndex)
        startingIndex += 1
        let buffer = buffer + String(char)
        
        return char.isStringIndicator ? .stringLiteral(symbolTable.safeAdd(buffer)) : stringState(buffer)
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
