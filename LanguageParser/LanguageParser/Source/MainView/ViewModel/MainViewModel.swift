//
//  CodingSpaceViewModel.swift
//  LanguageParser
//
//  Created by Snow Lukin on 16.03.2023.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var code: String = """
    int a = 10;
    float b = .01;
    string c = \"Something\";
    """
    
    @Published private(set) var savedCode: String = ""
    
    func updateCode(with newCode: String) {
        savedCode = newCode
    }
}
