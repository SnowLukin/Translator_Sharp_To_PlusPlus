//
//  LexicalAnalyzer.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//


import Foundation

/*
 This code is an implementation of a lexical analyzer for a C# programming language. The analyzer reads a string of code and generates a sequence of tokens that represent the language's keywords, literals, and other syntax elements.

 The `LexicalAnalyzer` class has several properties that store different types of tokens: identifierTable for variable, class, or function names, valueTable for numbers, and symbolTable for string values. The code property is the input string that the analyzer reads.

 The `tokens` property is a computed property that returns an array of LexicalTokens generated by analyzing the input code.
 The `tokensRowValue` property generates a string that represents the sequence of tokens in a single line.

 The reset method clears all the tables and the input code.

 The `startState` method is the entry point for the analyzer. It checks the first character of the input code and decides which state to enter based on the character's type. The method returns a LexicalToken object that represents the token that was parsed.

 The `identifierState`, `intState`, `floatState`, and stringState methods represent the different states that the analyzer can be in while parsing the input code. Each method takes a buffer argument that represents the characters that have been parsed so far.

 The `commentState` and `multiCommentState` methods handle single-line and multi-line comments, respectively.
 */


class LexicalAnalyzer {
    
    var identifierTable: [String:UserToken] = [:]   // Names of variable, classes or functions
    var valueTable: [String:UserToken] = [:]    // Numbers
    var symbolTable: [String:UserToken] = [:]   // String values
    
    var tokens = [LexicalToken]()
    
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
    
    var currentCode: String {
        code
    }
    
    private var code = ""
    
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
        valueTable.removeAll()
        symbolTable.removeAll()
    }
    
    private func updateTokens() {
        startingIndex = 0
        
        while startingIndex < code.count {
            guard let token = startState() else { continue }
            // print(token)
            tokens.append(token)
        }
    }
}


// MARK: - States
extension LexicalAnalyzer {
    private func startState() -> LexicalToken? {
        let char = code.at(startingIndex)
        startingIndex += 1
        
        if char.isIdentifier { return identifierState(String(char)) }
        if char.isSeparator { return includeSeparators ? .separator(String(char)) : nil }
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
            if startingIndex < code.count { return floatState(buffer + String(char)) }
            fatalError("Expected number after a dot")
        case _ where char.isNumber:
            startingIndex += 1
            let buffer = buffer + String(char)
            return startingIndex < code.count ? intState(buffer) : .integerLiteral(valueTable.safeAdd(buffer))
        case _ where buffer.first != ".":
            return .integerLiteral(valueTable.safeAdd(buffer))
        default:
            return .floatLiteral(valueTable.safeAdd("0" + buffer))
        }
    }
    
    private func floatState(_ buffer: String = "") -> LexicalToken {
        if startingIndex >= code.count { return .floatLiteral(valueTable.safeAdd(buffer)) }
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
