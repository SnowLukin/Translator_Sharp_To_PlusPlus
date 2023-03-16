//
//  PolishNotationView.swift
//  LanguageParser
//
//  Created by Snow Lukin on 09.03.2023.
//

import SwiftUI

struct PolishNotationView: View {
    
    @StateObject private var viewModel = PolishNotationViewModel()
    var inputCode: String
    
    var body: some View {
        TextEditor(text: $viewModel.polishNotation)
            .modifier(CodingTextEditModifier())
            .onAppear {
                viewModel.update(with: inputCode)
            }
    }
}
