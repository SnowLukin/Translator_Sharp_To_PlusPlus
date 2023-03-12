//
//  PolishNotationConverter.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import Foundation


class PolishNotationConverter {
    
    private var lexemas = [Lexema]()
    
    private var stack = Stack<Lexema>()
    private(set) var output = [Lexema]()
    
    func update(_ lexemas: [Lexema]) {
        self.lexemas = lexemas
        run()
    }
    
    /// Uses `Shunting Yard algorithm`
    private func run() {
        
        output.removeAll()
        stack.removeAll()
        
        print(lexemas.map {  $0.value })
        for (index, lexema) in lexemas.enumerated() {
            
            // Printing log
            print("Lexema: \(lexema.value)")
            print("--------")
            print("Stack")
            print(stack.makeIterator().map { $0.value })
            print("--------")
            print("Output")
            print(output.map { $0.value })
            print()
            
            switch lexema.type {
            case .constant, .literal, .identifier:
                output.append(lexema)
            case .keyword:
                handleKeyword(lexema)
            case .operator:
                handleOperator(lexema)
            case .divider:
                handleDivider(lexema, index)
            default:
                break
            }
        }
        
        while let operatorLexema = stack.pop() {
            output.append(operatorLexema)
        }
    }
    
}
 

extension PolishNotationConverter: SystemTables {
    
    private func handleIdentifier(_ lexema: Lexema, _ currentIndex: Int) {
        if stack.top?.type == .declaration, let topLexema = stack.pop() {
            let nextID = topLexema.id + 1
            let newLexema = Lexema(id: nextID, value: "DC(\(nextID))", type: .declaration)
            stack.push(newLexema)
        }
    }
    
    private func handleKeyword(_ lexema: Lexema) {
        switch lexema.value {
        case "if":
            stack.push(lexema)
        case "else":
            while let popedLexema = stack.pop() {
                if popedLexema.type == .mark {
                    let nextID = popedLexema.id + 1
                    let mark = Lexema(id: nextID, value: "M\(nextID)", type: .mark)
                    let markForOutput = Lexema(id: nextID, value: "M\(nextID)_goto_M\(popedLexema.id):", type: .mark)
                    stack.push(mark)
                    output.append(markForOutput)
                    break
                }
                output.append(popedLexema)
            }
        case "return":
            stack.push(lexema)
        case "int", "float", "string":
            stack.push(lexema)
            stack.push(Lexema(id: 1, value: "DC(1)", type: .declaration))
        default:
            output.append(lexema)
        }
    }
    
    private func handleOperator(_ lexema: Lexema) {
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
    
    private func handleDivider(_ lexema: Lexema, _ currentIndex: Int) {
        switch lexema.value {
        case ";":
            while let popedLexema = stack.pop() {
                if popedLexema <= lexema {
                    stack.push(popedLexema)
                    break
                }
                
                output.append(popedLexema)
            }
        case ",":
            
            if stack.top?.type == .declaration, let topLexema = stack.pop() {
                let nextID = topLexema.id + 1
                let newLexema = Lexema(id: nextID, value: "DC(\(nextID))", type: .declaration)
                stack.push(newLexema)
                break
            }
            
            while let popedLexema = stack.pop() {
                if popedLexema.type == .functionCall {
                    let nextID = popedLexema.id + 1
                    let newFunctionCall = Lexema(id: nextID, value: "FC(\(nextID))", type: .functionCall)
                    stack.push(newFunctionCall)
                    stack.push(Lexema(id: dividers["("]!, value: "(", type: .divider))
                    break
                }
                if popedLexema.isOpeningRoundBracket { continue }
                output.append(popedLexema)
            }
        case "(":
            if let previousLexema = lexemas.at(currentIndex - 1), previousLexema.type == .identifier {
                stack.push(Lexema(id: 1, value: "FC(\(1))", type: .functionCall))
            }
            stack.push(lexema)
        case ")":
            while let popedLexema = stack.pop(), !popedLexema.isOpeningRoundBracket {
                output.append(popedLexema)
            }
            if stack.top?.type == .functionCall, let fc = stack.pop() {
                let nextID = fc.id + 1
                let newFC = Lexema(id: nextID, value: "FC(\(nextID))", type: .functionCall)
                output.append(newFC)
            }
        case "[":
            if let previousLexema = lexemas.at(currentIndex - 1), previousLexema.isClosingSquareBracket { break }
            stack.push(Lexema(id: 2, value: "AAC(\(2))", type: .arrayAddressCounter))
        case "]":
            while let popedLexema = stack.pop() {
                if popedLexema.type == .arrayAddressCounter {
                    if let nextLexema = lexemas.at(currentIndex + 1), nextLexema.isOpeningSquareBracket {
                        let nextID = popedLexema.id + 1
                        let updatedAAC = Lexema(id: nextID, value: "AAC(\(nextID))", type: .arrayAddressCounter)
                        stack.push(updatedAAC)
                    } else {
                        output.append(popedLexema)
                    }
                    break
                }
                output.append(popedLexema)
            }
        case "{":
            while let popedLexema = stack.pop() {
                if popedLexema.type == .keyword, popedLexema.value == "if" {
                    let mark = Lexema(id: 1, value: "M1", type: .mark)
                    let markForOutput = Lexema(id: 1, value: "M1_Conditional", type: .mark)
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
        case "}":
            if let nextLexema = lexemas.at(currentIndex + 1), nextLexema.type == .keyword, nextLexema.value == "else" {
                break
            }
            while let popedLexema = stack.pop() {
                
                if popedLexema.type == .mark {
                    let newLexema = Lexema(id: popedLexema.id, value: popedLexema.value + ":", type: .mark)
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
