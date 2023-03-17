//
//  PolishNotationConverter.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import Foundation

/*
 while(a > b) {
    a++;
 }
 
 a b > MC(1) a ++ MC(1):
 
 int funcName(int a) {
    a++;
 }
 
 funcName a 1 int 2 1 int Start a ++ End
 */


class PolishNotationConverter {
    
    private var lexemes = [Lexeme]()
    
    private var stack = Stack<Lexeme>()
    private(set) var output = [Lexeme]()
    
    func update(_ lexemes: [Lexeme]) {
        self.lexemes = lexemes
        run()
    }
    
    /// Uses `Shunting Yard algorithm`
    private func run() {
        
        output.removeAll()
        stack.removeAll()
        
        print(lexemes.map {  $0.value })
        for (index, lexeme) in lexemes.enumerated() {
            
            // Printing log
            print("Lexema: \(lexeme.value)")
            print("--------")
            print("Stack")
            print(stack.makeIterator().map { $0.value })
            print("--------")
            print("Output")
            print(output.map { $0.value })
            print()
            
            switch lexeme.type {
            case .constant, .literal, .identifier:
                output.append(lexeme)
            case .keyword:
                handleKeyword(lexeme)
            case .operator:
                handleOperator(lexeme)
            case .divider:
                handleDivider(lexeme, index)
            default:
                break
            }
        }
        
        while let operatorLexema = stack.pop() {
            output.append(operatorLexema)
        }
    }
    
}
 

extension PolishNotationConverter {
    
    private func handleIdentifier(_ lexema: Lexeme, _ currentIndex: Int) {
        if stack.top?.type == .declaration, let topLexema = stack.pop() {
            let nextID = topLexema.id + 1
            let newLexema = Lexeme(id: nextID, value: "DC(\(nextID))", type: .declaration)
            stack.push(newLexema)
        }
    }
    
    private func handleKeyword(_ lexema: Lexeme) {
        switch lexema.value {
        case "if":
            stack.push(lexema)
        case "else":
            while let popedLexema = stack.pop() {
                if popedLexema.type == .mark {
                    let nextID = popedLexema.id + 1
                    let mark = Lexeme(id: nextID, value: "M\(nextID)", type: .mark)
                    let markForOutput = Lexeme(id: nextID, value: "M\(nextID)_goto_M\(popedLexema.id):", type: .mark)
                    stack.push(mark)
                    output.append(markForOutput)
                    break
                }
                output.append(popedLexema)
            }
        case "return":
            stack.push(lexema)
        case "while":
            stack.push(lexema)
        case "int", "float", "string":
            stack.push(lexema)
            stack.push(Lexeme(id: 1, value: "DC(1)", type: .declaration))
        default:
            output.append(lexema)
        }
    }
    
    private func handleOperator(_ lexema: Lexeme) {
        if stack.isEmpty || stack.top! < lexema {
            stack.push(lexema)
        } else {
            while let popedLexema = stack.pop() {
                if popedLexema < lexema {
                    stack.push(popedLexema)
                    break
                }
                output.append(popedLexema)
            }
            stack.push(lexema)
        }
    }
    
    private func handleDivider(_ lexeme: Lexeme, _ currentIndex: Int) {
        switch lexeme.value {
        case ";":
            while let popedLexeme = stack.pop() {
                if popedLexeme <= lexeme {
                    stack.push(popedLexeme)
                    break
                }
                
                output.append(popedLexeme)
            }
        case ",":
            
            if stack.top?.type == .declaration, let nextLexeme = lexemes.at(currentIndex + 1), nextLexeme.type != .keyword, let topLexema = stack.pop() {
                let nextID = topLexema.id + 1
                let newLexema = Lexeme(id: nextID, value: "DC(\(nextID))", type: .declaration)
                stack.push(newLexema)
                break
            }
            
            while let popedLexema = stack.pop() {
                if popedLexema.type == .functionCall {
                    let nextID = popedLexema.id + 1
                    let newFunctionCall = Lexeme(id: nextID, value: "FC(\(nextID))", type: .functionCall)
                    stack.push(newFunctionCall)
                    stack.push(Lexeme(id: SystemTable.divider.getId(for: "(")!, value: "(", type: .divider))
                    break
                }
                if popedLexema.isOpeningRoundBracket { continue }
                output.append(popedLexema)
            }
        case "(":
            if let previousLexema = lexemes.at(currentIndex - 1), previousLexema.type == .identifier {
                stack.push(Lexeme(id: 1, value: "FC(\(1))", type: .functionCall))
            }
            stack.push(lexeme)
        case ")":
            while let popedLexema = stack.pop(), !popedLexema.isOpeningRoundBracket {
                output.append(popedLexema)
            }
            if stack.top?.type == .functionCall, let fc = stack.pop() {
                let nextID = fc.id + 1
                let newFC = Lexeme(id: nextID, value: "FC(\(nextID))", type: .functionCall)
                output.append(newFC)
            }
        case "[":
            if let previousLexema = lexemes.at(currentIndex - 1), previousLexema.isClosingSquareBracket { break }
            stack.push(Lexeme(id: 2, value: "AAC(\(2))", type: .arrayAddressCounter))
        case "]":
            while let popedLexema = stack.pop() {
                if popedLexema.type == .arrayAddressCounter {
                    if let nextLexema = lexemes.at(currentIndex + 1), nextLexema.isOpeningSquareBracket {
                        let nextID = popedLexema.id + 1
                        let updatedAAC = Lexeme(id: nextID, value: "AAC(\(nextID))", type: .arrayAddressCounter)
                        stack.push(updatedAAC)
                    } else {
                        output.append(popedLexema)
                    }
                    break
                }
                output.append(popedLexema)
            }
        case "{":
            var isFunctionDeclaration = false
            
            if output.last?.type == .functionCall {
                isFunctionDeclaration.toggle()
            }
            
            while let popedLexema = stack.pop() {
                
                if popedLexema.type == .keyword, popedLexema.value == "while" {
                    let mark = Lexeme(id: 1, value: "MC1_Conditional", type: .loopMark)
                    stack.push(mark)
                    output.append(mark)
                    break
                }
                
                if popedLexema.type == .keyword, popedLexema.value == "if" {
                    let mark = Lexeme(id: 1, value: "M1", type: .mark)
                    let markForOutput = Lexeme(id: 1, value: "M1_Conditional", type: .mark)
                    stack.push(mark)
                    output.append(markForOutput)
                    break
                }
                
                if popedLexema.type == .mark {
                    stack.push(popedLexema)
                    break
                }
                output.append(popedLexema)
            }
            if isFunctionDeclaration {
                let startBodyLexeme = Lexeme(id: 0, value: "FBS", type: .funcBodyStart)
                output.append(startBodyLexeme)
                stack.push(startBodyLexeme)
            }
        case "}":
            if let nextLexema = lexemes.at(currentIndex + 1), nextLexema.type == .keyword, nextLexema.value == "else" {
                break
            }
            while let popedLexema = stack.pop() {
                
                if popedLexema.type == .funcBodyStart {
                    let endBodyLexeme = Lexeme(id: 0, value: "FBE", type: .funcBodyEnd)
                    output.append(endBodyLexeme)
                    break
                }
                
                if popedLexema.type == .loopMark {
                    let newLexema = Lexeme(id: popedLexema.id, value: popedLexema.value + ":", type: .loopMark)
                    output.append(newLexema)
                    break
                }
                
                if popedLexema.type == .mark {
                    let newLexema = Lexeme(id: popedLexema.id, value: popedLexema.value + ":", type: .mark)
                    output.append(newLexema)
                    break
                }
                
                output.append(popedLexema)
            }
        default:
            break
        }
    }
}
