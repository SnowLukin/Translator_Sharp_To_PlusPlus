//
//  LexicalAnalyzer.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//


import SwiftUI

<<<<<<< HEAD
=======
enum LexicalToken {
    case Identifier(String)
    case Keyword(String)
    case IntegerLiteral(String)
    case FloatLiteral(String)
    case StringLiteral(String)
    case Operator(String)
    case Divider(String)
    
    func getState() -> (state: LexicalState, value: String) {
        switch self {
        case .Identifier(let string):
            return (.Identifier, string)
        case .Keyword(let string):
            return (.Keyword, string)
        case .IntegerLiteral(let string):
            return (.IntegerLiteral, string)
        case .FloatLiteral(let string):
            return (.FloatLiteral, string)
        case .StringLiteral(let string):
            return (.StringLiteral, string)
        case .Operator(let string):
            return (.Operator, string)
        case .Divider(let string):
            return (.Divider, string)
        }
    }
}

>>>>>>> parent of 9f0d6ac (Basic ui, fixed problem with not adding divider token without whitespace)
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

class LexicalAnalyzer: ObservableObject {
    
    let keyword: Set<String> = ["class", "if", "else", "while", "int", "float", "double", "string", "namespace", "void", "static", "using", "System", "break", "return"] // Add additional keywords as needed
    let operators: Set<Character> = ["+", "-", "*", "/", "%", "=", ">", "<", "!", "&", "|"]
    let punctuations: Set<Character> = [".", ",", ";", ":", "(", ")", "[", "]", "{", "}"]
    let multiCharOperators: Set<String> = ["==", "!=", ">=", "<=", "&&", "||", "++", "--", "+=", "-=", "*=", "/=", "%=", "&=", "|=", "^=", "<<", ">>"]
    
    func translate(input: String) -> [LexicalToken] {
        var state: LexicalState = .Start
        var tokens: [LexicalToken] = []
        var buffer = ""
        
        for char in input {
            switch state {
            case .Start:
                if char.isLetter {
                    state = .Identifier
                    buffer.append(char)
                } else if char.isWhitespace {
                    continue
                } else if char.isNumber {
                    state = .IntegerLiteral
                    buffer.append(char)
                } else if char == "\"" {
                    state = .StringLiteral
<<<<<<< HEAD
                } else if Dividers.isToken(char) {
=======
                } else if punctuations.contains(char) {
>>>>>>> parent of 9f0d6ac (Basic ui, fixed problem with not adding divider token without whitespace)
                    tokens.append(.Divider(String(char)))
                } else if operators.contains(char) {
                    state = .Operator
                    buffer.append(char)
                }
            case .Identifier:
                if char.isLetter || char.isNumber || char == "_" {
                    buffer.append(char)
                } else {
                    if keyword.contains(buffer) {
                        tokens.append(.Keyword(buffer))
                    } else {
                        tokens.append(.Identifier(buffer))
                    }
                    
                    state = .Start
                    buffer = ""
                    continue // re-evaluate this char in the new state
                }
            case .IntegerLiteral:
                if char.isNumber {
                    buffer.append(char)
                } else if char == "." {
                    state = .FloatLiteral
                    buffer.append(char)
                } else {
                    tokens.append(.IntegerLiteral(buffer))
                    state = .Start
                    buffer = ""
                    continue
                }
            case .FloatLiteral:
                if char.isNumber {
                    buffer.append(char)
                } else {
                    tokens.append(.FloatLiteral(buffer))
                    state = .Start
                    buffer = ""
                    continue
                }
            case .StringLiteral:
                if char == "\"" {
                    tokens.append(.StringLiteral(buffer))
                    state = .Start
                    buffer = ""
                } else {
                    buffer.append(char)
                }
            case .Operator:
                let possibleOp = buffer + String(char)
                if multiCharOperators.contains(possibleOp) {
                    buffer = possibleOp
                } else {
                    tokens.append(.Operator(buffer))
                    state = .Start
                    buffer = ""
                    continue
                }
            case .Divider:
                tokens.append(.Divider(String(char)))
                state = .Start
                buffer = ""
            case .Keyword:
                if keyword.contains(buffer) {
                    tokens.append(.Keyword(buffer))
                } else {
                    tokens.append(.Identifier(buffer))
                }
            }
        }
        
        // handle any remaining buffered token
        if let finalToken = finalizeToken(state, buffer) {
            tokens.append(finalToken)
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
