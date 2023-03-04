//
//  LexicalAlalyzerView.swift
//  TranslatorSharp2Plus
//
//  Created by Snow Lukin on 04.03.2023.
//

import SwiftUI

struct LexicalAlalyzerView: View {
    @StateObject private var viewModel = LexicalAnalyzer()
    
    @State private var sharpCode: String = ""
    @State private var resultTokens: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextEditor(text: $sharpCode)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text(resultTokens)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Button("Run") {
                let tokens = viewModel.translate(input: sharpCode)
                let tokensToStr = tokens.map { $0.getStringRepresentation() }.joined(separator: " ")
                resultTokens = tokensToStr
            }
            .padding()
        }
    }
}

struct LexicalAlalyzerView_Previews: PreviewProvider {
    static var previews: some View {
        LexicalAlalyzerView()
    }
}
