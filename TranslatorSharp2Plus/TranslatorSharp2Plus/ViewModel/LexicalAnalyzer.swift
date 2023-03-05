//
//  LexicalAnalyzer.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//


import SwiftUI


class LexicalAnalyzer: ObservableObject {
    
    enum LexicalState {
        case Start
        case Identifier
        case Keyword
        case IntegerLiteral
        case FloatLiteral
        case StringLiteral
        case Operator
        case Divider
    }
    
    func translate(input: String) -> [LexicalToken] {
        var state: LexicalState = .Start
        var tokens: [LexicalToken] = []
        var buffer = ""
        
        var input = input
        
        while let char = input.first {
            print(char)
            switch state {
            case .Start:
                if char.isIdentifier() {
                    state = .Identifier
                    buffer.append(char)
                } else if Separators.isToken(char) {
                    tokens.append(.Separator(String(char)))
                } else if char.isNumber {
                    state = .IntegerLiteral
                    buffer.append(char)
                } else if char.isStartOfStringLiteral() {
                    state = .StringLiteral
                } else if Dividers.isToken(char) {
                    tokens.append(.Divider(String(char)))
                } else if Operators.isToken(char) {
                    state = .Operator
                    buffer.append(char)
                } else {
                    fatalError("Met unexpected character: \(char).")
                }
                input.removeFirst()
                continue
            case .Identifier:
                if char.isIdentifier() {
                    buffer.append(char)
                    input.removeFirst()
                    continue
                } else {
                    let token: LexicalToken = Keywords.isToken(buffer) ? .Keyword(buffer) : .Identifier(buffer)
                    tokens.append(token)
                }
            case .IntegerLiteral:
                if char.isNumber {
                    buffer.append(char)
                    input.removeFirst()
                    continue
                } else if char == "." {
                    state = .FloatLiteral
                    buffer.append(char)
                    input.removeFirst()
                    continue
                } else {
                    tokens.append(.IntegerLiteral(buffer))
                }
            case .FloatLiteral:
                if char.isNumber {
                    buffer.append(char)
                    input.removeFirst()
                    continue
                } else {
                    tokens.append(.FloatLiteral(buffer))
                }
            case .StringLiteral:
                input.removeFirst()
                if char.isEndOfStringLiteral() {
                    tokens.append(.StringLiteral(buffer))
                } else {
                    buffer.append(char)
                    continue
                }
            case .Operator:
                let possibleOperation = buffer + String(char)
                if Operators.isToken(possibleOperation) {
                    buffer = possibleOperation
                    input.removeFirst()
                    continue
                } else {
                    tokens.append(.Operator(buffer))
                }
            case .Divider:
                tokens.append(.Divider(String(char)))
            case .Keyword:
                tokens.append(.Keyword(buffer))
            }
            
            state = .Start
            buffer.removeAll()
        }
        
        return tokens
    }
    
    private func finalizeToken(_ state: LexicalState, _ token: String) -> LexicalToken? {
        switch state {
        case .Identifier:
            return .Identifier(token)
        case .Keyword:
            return .Keyword(token)
        case .IntegerLiteral:
            return .IntegerLiteral(token)
        case .FloatLiteral:
            return .FloatLiteral(token)
        case .StringLiteral:
            return .StringLiteral(token)
        case .Operator:
            return .Operator(token)
        case .Divider:
            return .Divider(token)
        default:
            return nil
        }
    }
}
