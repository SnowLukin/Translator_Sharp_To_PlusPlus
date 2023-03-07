//
//  LexicalAnalyzer.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//


import Foundation

class LexicalAnalyzer {
    
    var tokensRowValue: String {
        tokens.map { $0.toString }.joined()
    }
    
    var currentCode: String {
        code
    }
    
    var identifiers: [Token] {
        identifierTable
    }
    
    var numerics: [Token] {
        numericTable
    }
    
    var stringLiterals: [Token] {
        stringLiteralTable
    }
    
    var lexemas: [Token] {
        tokens
    }
    
    private var code = ""
    
    private var tokens = [Token]()
    
    private var identifierTable: [Token] = []
    private var numericTable: [Token] = []
    private var stringLiteralTable: [Token] = []
    
    private var buffer = ""
    private var startingIndex = 0
    private var includeSeparators = false
    
    func update(with code: String = "", includeSeparators: Bool = false) {
        self.code = code
        self.includeSeparators = includeSeparators
        resetTables()
        updateTokens()
    }
    
    private func resetTables() {
        tokens.removeAll()
        identifierTable.removeAll()
        numericTable.removeAll()
        stringLiteralTable.removeAll()
    }
    
    private func updateTokens() {
        startingIndex = 0
        while startingIndex < code.count {
            if let token = startState() {
                print(token)
                tokens.append(token)
            }
        }
    }
}


// MARK: - States
extension LexicalAnalyzer {
    
    private func startState() -> Token? {
        let char = code.at(startingIndex)
        startingIndex += 1
        
        switch char {
        case symbols:
            return identifierState(String(char))
        case separators:
            return includeSeparators ? char.asSeparator! : nil
        case ".":
            return floatState("0" + String(char))
        case numbers:
            return intState(String(char))
        case "\"":
            return stringState(String(char))
        case dividers:
            return char.asDivider!
        case operators:
            return operatorState(String(char))
        case "/":
            return startingCommentState()
        default:
            fatalError("Met unexpected character: \(char).")
        }
        
    }
    
    private func startingCommentState() -> Token? {
        let char = code.at(startingIndex)
        
        switch char {
        case "/":
            return commentState()
        case "*":
            return multiCommentState()
        default:
            fatalError("Unexpected symbol after \"/\": \(char)")
        }
    }
    
    private func commentState() -> Token? {
        if startingIndex < code.count, code.at(startingIndex) != "\n" {
            startingIndex += 1
            return commentState()
        }
        return nil
    }
    
    private func multiCommentState() -> Token? {
        startingIndex += 1
        let char = code.at(startingIndex)
        if startingIndex < code.count - 1, char == "*", code.at(startingIndex + 1) == "/" {
            startingIndex += 2
            return nil
        }
        if startingIndex >= code.count - 1 { fatalError("Multiline comment doesnt close.") }
        return multiCommentState()
    }
    
    private func identifierState(_ buffer: String = "") -> Token {
        let char = code.at(startingIndex)
        
        switch char {
        case symbols:
            startingIndex += 1
            return identifierState(buffer + String(char))
        case _ where keywords ~= buffer:
            return buffer.asKeyword!
        default:
            return identifierTable.safeAdd(buffer, .identifier)
        }
    }
    
    private func intState(_ buffer: String = "") -> Token {
        let char = code.at(startingIndex)
        
        switch char {
        case ".":
            startingIndex += 1
            if startingIndex < code.count { return floatState(buffer + String(char)) }
            fatalError("Expected number after a dot")
        case numbers:
            startingIndex += 1
            let buffer = buffer + String(char)
            return startingIndex < code.count ? intState(buffer) : numericTable.safeAdd(buffer, .numericLiteral)
        case _ where buffer.first != ".":
            return numericTable.safeAdd(buffer, .numericLiteral)
        default:
            return numericTable.safeAdd("0" + buffer, .numericLiteral)
        }
    }
    
    private func floatState(_ buffer: String = "") -> Token {
        if startingIndex >= code.count { return numericTable.safeAdd(buffer, .numericLiteral) }
        let char = code.at(startingIndex)
        
        switch char {
        case "e", "E":
            startingIndex += 1
            return exponentState(buffer + String(char))
        case numbers:
            startingIndex += 1
            return floatState(buffer + String(char))
        default:
            return numericTable.safeAdd(buffer, .numericLiteral)
        }
    }

    private func exponentState(_ buffer: String = "") -> Token {
        let char = code.at(startingIndex)
        
        switch char {
        case "+", "-":
            startingIndex += 1
            return signedExponentState(buffer + String(char))
        case numbers:
            startingIndex += 1
            return unsignedExponentState(buffer + String(char))
        default:
            fatalError("Met unexpected character in exponent: \(char).")
        }
    }
    
    private func signedExponentState(_ buffer: String = "") -> Token {
        let char = code.at(startingIndex)
        
        switch char {
        case numbers:
            startingIndex += 1
            return unsignedExponentState(buffer + String(char))
        default:
            fatalError("Expected a digit in signed exponent: \(char).")
        }
    }

    private func unsignedExponentState(_ buffer: String = "") -> Token {
        let char = code.at(startingIndex)
        
        switch char {
        case numbers:
            startingIndex += 1
            return unsignedExponentState(buffer + String(char))
        default:
            return numericTable.safeAdd(buffer, .numericLiteral)
        }
    }
    
    private func stringState(_ buffer: String = "") -> Token? {
        let char = code.at(startingIndex)
        startingIndex += 1
        let buffer = buffer + String(char)
        return char == "\"" ? stringLiteralTable.safeAdd(buffer, .stringLiteral) : stringState(buffer)
    }
    
    private func operatorState(_ buffer: String = "") -> Token? {
        let char = code.at(startingIndex)
        let possibleOperation = buffer + String(char)
        
        switch possibleOperation {
        case operators:
            startingIndex += 1
            return operatorState(possibleOperation)
        default:
            return buffer.asOperator!
        }
    }
}
