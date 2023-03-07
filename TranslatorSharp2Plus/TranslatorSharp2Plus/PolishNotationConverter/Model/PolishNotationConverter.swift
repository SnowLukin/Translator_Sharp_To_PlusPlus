//
//  PolishNotationConverter.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import Foundation


class PolishNotationConverter {
    private var operatorStack: Stack<Token> = Stack<Token>()
    private var outputQueue: Queue<Token> = Queue<Token>()
    
    func convert(_ tokens: [Token]) -> [Token] {
        
        operatorStack = Stack<Token>()
        outputQueue = Queue<Token>()
        
        // Shunting-yard algorithm
        for token in tokens {
            switch token.type {
            case .numericLiteral, .stringLiteral, .identifier:
                outputQueue.enqueue(token)
            case .operator:
                while let topOperator = operatorStack.top, topOperator.type == .operator,
                      topOperator.value != "(" && topOperator.precedence >= token.precedence {
                    outputQueue.enqueue(operatorStack.pop()!)
                }
                operatorStack.push(token)
            case .divider:
                if token.value == "(" {
                    operatorStack.push(token)
                } else {
                    while let topOperator = operatorStack.top, topOperator.value != "(" {
                        outputQueue.enqueue(operatorStack.pop()!)
                    }
                    let _ = operatorStack.pop()
                }
            case .separator where token.value != " ":
                outputQueue.enqueue(token)
            default:
                break
            }
        }
        
        while let _ = operatorStack.top {
            outputQueue.enqueue(operatorStack.pop()!)
        }
        
        return Array.from(outputQueue)
    }
}
