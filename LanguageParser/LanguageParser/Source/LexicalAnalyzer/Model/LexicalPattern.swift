//
//  LexicalPattern.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import Foundation

enum LexicalPattern: String {
    /// This regex should match strings like:
    ///  // This is a comment
    ///  //This is another comment with symbols like $!@#
    ///  /* This is a multi-line comment */
    ///  /* This is a multi-line comment with symbols like $!@# */.
    case comment = #"^(//.*|/\*(([^\*]|\s)*)\*/)"#
    
    /// Should match any operators like: +, ++, -= etc.
    case `operator` = #"^([-*+%=><!&|]{1,2}|[/])"#
    
    /// Should match strings for identifier names
    case identifier = "^([a-zA-Z_][a-zA-Z0-9_]*)"
    
    /// Should match string like: "something"
    case literal = "^(\"[^\n\"]*\")"
    
    /// Should match strings like: 123, 0.456, .789, 1.23e4, 1.23E+4, 0.456, 1.23e-4, and so on.
    case constant = #"^(((\d)+([\.](\d)*([eE][+-]?(\d)+)?)?|([\.](\d)+([eE][+-]?(\d)+)?)))"#

    /// Should match strings like: {, }, (, ), `,`, ;, [, ]
    case divider = "^([\\{\\}\\(\\),;\\[\\]])"
    
    /// Should match strings of whitespaces, newLines and tabs
    case separator = #"^([\s])"#
}
