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
                    .font(.system(size: 12, design: .monospaced))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .autocorrectionDisabled()
                TextEditor(text: $resultTokens)
                    .font(.system(size: 12, design: .monospaced))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .disabled(true)
                    
            }
            HStack {
                Button("Run") {
                    let tokens = viewModel.translate(input: sharpCode)
                    let tokensToStr = tokens.map { $0.getStringRepresentation() }.joined(separator: "")
                    resultTokens = tokensToStr
//                    let tokens = viewModel.tokenize(code: sharpCode)
//                    print(tokens)
                }
                .padding()
                
                Button("Clear") {
                    sharpCode = ""
                    resultTokens = ""
                }
                .padding()
            }
        }
    }
}

struct LexicalAlalyzerView_Previews: PreviewProvider {
    static var previews: some View {
        LexicalAlalyzerView()
    }
}
