//
//  PatternMatching.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 07.03.2023.
//

import Foundation

func ~=(pattern: Set<Character>, value: Character) -> Bool {
    pattern.contains(value)
}

func ~=(pattern: Set<String>, value: String) -> Bool {
    pattern.contains(value)
}

func ~=(pattern: [Character:Int], value: Character) -> Bool {
    pattern[value] != nil
}

func ~=(pattern: [String:Int], value: String) -> Bool {
    pattern[value] != nil
}

func ~=(pattern: [String:Int], value: Character) -> Bool {
    pattern[String(value)] != nil
}

func ~=(regex: Regex<Substring>, value: Character) -> Bool {
    (try? regex.wholeMatch(in: String(value))) != nil
}

func ~=(regex: Regex<Substring>, value: String) -> Bool {
    (try? regex.wholeMatch(in: value)) != nil
}
