//
//  Array+Extension.swift
//  LanguageParser
//
//  Created by Snow Lukin on 10.03.2023.
//

import Foundation

extension Array {
    func at(_ index: Int) -> Element? {
        if index < 0 { return nil }
        return index < self.count ? self[index] : nil
    }
}
